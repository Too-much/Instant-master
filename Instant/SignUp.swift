//
//  Subscribe.swift
//  Instant
//
//  Created by Xavier de Cazenove on 06/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit
import Firebase

class SignUp: UIViewController {
    
    @IBOutlet var username : UITextField!
    @IBOutlet var email : UITextField!
    @IBOutlet var password : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        username.setBottomBorder()
        email.setBottomBorder()
        password.setBottomBorder()
        
    }
    
    @IBAction func signUpAuthentification(sender : Any?){
        
        if username.text != nil && email.text != nil && password.text != nil {
            
            // Création d'un USER
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ User, Error in
                if Error == nil && User != nil{
                    print("User created !")
                    
                    // Création d'un USERNAME pour le USER
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.username.text
                    changeRequest?.commitChanges{ Error in
                        if Error == nil{
                            print("User display name changed !")
                            
                            //On récupère Main.storyboard
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            //On crée une instance d'acceuil à partir du storyboard
                            let signUp = storyboard.instantiateViewController(withIdentifier: "pellicule") as! ViewController
                            //On montre le nouveau controller
                            self.navigationController?.showDetailViewController(signUp, sender: self)
                        }
                    }
                    
                    
                } else{
                    print("Error creating user : \(String(describing: Error?.localizedDescription))")
                }
            }
        } else{
            alert("Error", message: "Please fill up all fields in order to subscribe")
        }
    }
    
    
    func alert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
