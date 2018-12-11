//
//  ViewController.swift
//  Instant
//
//  Created by Léonard Devincre on 28/11/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var cameraLuncher: UIButton!
    @IBOutlet var signOut : UIButton!
    @IBOutlet weak var imageView: UIImageView!
    

    @IBOutlet var pelliculeCollectionView: UICollectionView!
    
    
    var pelArray: [Pellicule] = [Pellicule(_state: false, _nom: "addButton", _icone: "plus")]
    var numPellicule : Int = 0
    var chargementFinis : Bool = true
    
    //initialize an instance database
    let db =  Firestore.firestore()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    print("comprend rien")
                    self.chargementFinis = true
                }
            }
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print( pelArray.count)
        print("YOOoOOOOOOO")
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
    
    
    
    
    
    @IBAction func takePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker,animated: true,completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.contentMode = .scaleToFill
            imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logOutSettingButton(sender : Any?){
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    
}

