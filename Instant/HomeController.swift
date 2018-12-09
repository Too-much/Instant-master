//
//  HomeController.swift
//  Instant
//
//  Created by Léonard Devincre on 06/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class HomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet var popAddButton: UIView!
    @IBOutlet weak var pelliculeNameTF: UITextField!
    @IBOutlet var pelliculeCollectionView: UICollectionView!
    
    var pelArray: [Pellicule] = [Pellicule(_state: false, _nom: "addButton", _icone: "plus")]
    var numPellicule : Int = 0
    var chargementFinis : Bool = true
    
    //initialize an instance database
    let db =  Firestore.firestore()
    
    
    override func viewDidLoad() {
        getPelliculefromDB()
        NotificationCenter.default.addObserver(self, selector: #selector(addPellicule), name: NSNotification.Name("addPellicule"), object: nil)
    }
    
    @objc func addPellicule (){
        self.performSegue(withIdentifier: "GoToAddPellStoryBoard", sender:self)
    }
    
    
    func getPelliculefromDB(){
        if chargementFinis {
            chargementFinis=false
            pelArray = []
            //la première cellule sera le addbutton
            pelArray.append(Pellicule(_state: false, _nom: "addButton", _icone: "plus"))
            numPellicule = 0
            //on récupère les documents sur le firestore
            db.collection("Pellicule").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.pelArray.append(Pellicule(_state: false, _nom: document.documentID, _icone: "appareil_photo" ))
                        print("\(document.documentID) => \(document.data())")
                        print(self.numPellicule)
                        self.numPellicule = self.numPellicule + 1
                    }
                    self.pelliculeCollectionView.reloadData()
                    self.chargementFinis = true
                }
            }
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print( pelArray.count)
        return pelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        numPellicule = 0
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PelliculeCollectionViewCell
        cell.displayContent(pellicule: pelArray[indexPath.row])
        return cell
    }
    
    @IBAction func reloadfromDB(_ sender: Any) {
        getPelliculefromDB()
    }
    
}
