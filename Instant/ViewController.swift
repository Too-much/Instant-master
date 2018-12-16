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


    @IBOutlet var signOut : UIButton!
    @IBOutlet var label : UILabel!
    
    
    @IBOutlet var imageTest : UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var pelliculeCollectionView: UICollectionView!
    var user : UserProfile!
    var currentCell : String!
    
    
    
    //initialize an instance database
    let db =  Firestore.firestore()
    let storageRef = Storage.storage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = UserProfile(db: Firestore.firestore(), id : (Auth.auth().currentUser?.uid)!)
        NotificationCenter.default.addObserver(self, selector: #selector(collectionViewReload), name: NSNotification.Name("reload") , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadfromDB(_:)), name: NSNotification.Name("reloadFromDB"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(addPellicule), name: NSNotification.Name("addPellicule"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addImageView), name: NSNotification.Name("addImageView"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(takePhoto), name: NSNotification.Name("takePhoto"), object: nil)
    }
    
    @objc func addPellicule (){
        self.performSegue(withIdentifier: "GoToAddPellStoryBoard", sender:self)
    }
    
    @objc func addImageView(){
        //imageTest.image = user.tabPellicule[1].tabImage[1]
    }
    
    
    
    /// _________________ COLLECTION VIEW INIT _____________________ ///
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.tabPellicule.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PelliculeCollectionViewCell
        cell.displayContent(viewController: self,pellicule: user.tabPellicule[indexPath.row], pell_name: user.tabPellicule[indexPath.row].nom, pell_initDate: user.tabPellicule[indexPath.row].startDate)
        
        return cell
    }
    
    /// ______________________________________________________________ ///
    
    
    
    
    
    @IBAction func reloadfromDB(_ sender: Any) {
        self.user = UserProfile(db: Firestore.firestore(), id : (Auth.auth().currentUser?.uid)!)
        NotificationCenter.default.addObserver(self, selector: #selector(collectionViewReload), name: NSNotification.Name("reload") , object: nil)
    }
    
    @objc func collectionViewReload(){
        self.pelliculeCollectionView.reloadData()
    }
    
    

    
    
    /// _________________ TAKE PHOTO _____________________ ///
    
    @objc func takePhoto() {
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
            
            /// ****** INSERTION IMAGE DANS STORAGE ******** ///

            let random = generateRandomStringWithLength(length: 20)
            let metaDataForImage = StorageMetadata()
            metaDataForImage.contentType = "image/jpeg"
            
            var data = Data()
            data = (pickedImage.jpegData(compressionQuality: 0.8)!)
            
            let imageRef = Storage.storage().reference().child("users/" + self.user.id + "/" + random)
            _ = imageRef.putData(data, metadata: metaDataForImage){ (metadata,Error) in
                if Error != nil{
                    print(Error as Any)
                    return
                }else{
                    imageRef.downloadURL(completion: { (Url, Error) in
                        if Error != nil{
                            print(Error as Any)
                        }else{
                            let downloadUrl = Url?.absoluteString
                            print(downloadUrl!)
                            self.addDownloadURLToDatabase(downloadURL: downloadUrl!)
                        }
                    })
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func generateRandomStringWithLength(length: Int) -> String {
        
        var randomString = ""
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        for _ in 1...length {
            let randomIndex  = Int(arc4random_uniform(UInt32(letters.count)))
            let a = letters.index(letters.startIndex, offsetBy: randomIndex)
            randomString +=  String(letters[a])
        }
        
        return randomString
    }
    
    /// ______________________________________________________________ ///

    func addDownloadURLToDatabase(downloadURL : String){

    db.collection("users").document(user.id).collection("pellicule").document(self.currentCell).collection("images").document().setData([
            "downloadURL" : downloadURL]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document images successfully written!")
                }
        }
    }
    
    
    
    
    @IBAction func logOutSettingButton(sender : Any?){
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
}

