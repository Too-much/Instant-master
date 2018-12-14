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
    var user : UserProfile!
    
    
    
    //initialize an instance database
    let db =  Firestore.firestore()
    let storageRef = Storage.storage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = UserProfile(db: Firestore.firestore(), id : (Auth.auth().currentUser?.uid)!)
        NotificationCenter.default.addObserver(self, selector: #selector(collectionViewReload), name: NSNotification.Name("reload") , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadfromDB(_:)), name: NSNotification.Name("reloadFromDB"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(addPellicule), name: NSNotification.Name("addPellicule"), object: nil)
    }
    
    @objc func addPellicule (){
        self.performSegue(withIdentifier: "GoToAddPellStoryBoard", sender:self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.tabPellicule.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PelliculeCollectionViewCell
        cell.displayContent(pellicule: user.tabPellicule[indexPath.row], pell_name: user.tabPellicule[indexPath.row].nom, pell_initDate: user.tabPellicule[indexPath.row].startDate)
        
        return cell
    }
    
    @IBAction func reloadfromDB(_ sender: Any) {
        self.user = UserProfile(db: Firestore.firestore(), id : (Auth.auth().currentUser?.uid)!)
        NotificationCenter.default.addObserver(self, selector: #selector(collectionViewReload), name: NSNotification.Name("reload") , object: nil)
    }
    
    @objc func collectionViewReload(){
        self.pelliculeCollectionView.reloadData()
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

