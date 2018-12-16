//
//  addPellStoryBoardController.swift
//  Instant
//
//  Created by Léonard Devincre on 09/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//
import UIKit
import Firebase
import FirebaseFirestore

class addPellViewController : UIViewController {
    @IBOutlet weak var pellNameTF: UITextField!
    
    //initialize an instance database
    let db =  Firestore.firestore()
    var user : UserProfile!
    
    @IBAction func closeAddPell(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addPellButton(_ sender: Any) {
        //on récupère les informations et on les envoies dans la firebase
        self.user = UserProfile(db: Firestore.firestore(), id : (Auth.auth().currentUser?.uid)!)
        
        if(pellNameTF.text != nil)
        {
        db.collection("users").document(user.id).collection("pellicule").document(pellNameTF.text!).setData([
                "name": pellNameTF.text!,
                "date_init": initDate(),
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
            }
            NotificationCenter.default.post(name: NSNotification.Name("reloadFromDB"), object: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

func initDate () -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = Date.init()
    let stringDate = formatter.string(from: date)
    return stringDate
}
