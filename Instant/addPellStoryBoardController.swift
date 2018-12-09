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

class addPellStoryBoard : UIViewController {
    @IBOutlet weak var pellNameTF: UITextField!
    
    //initialize an instance database
    let db =  Firestore.firestore()
    
    @IBAction func closeAddPell(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addPellButton(_ sender: Any) {
        //on récupère les informations et on les envoies dans la firebase
        if(pellNameTF.text != nil)
        {
            // Add a new document in collection "cities"
            db.collection("Pellicule").document(pellNameTF.text!).setData([
                "name": pellNameTF.text!,
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
