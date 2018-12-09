//
//  Login.swift
//  Instant
//
//  Created by Léonard Devincre on 07/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit
import Firebase

extension UITextField{
    
    func setBottomBorder(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

class LogIn: UIViewController {
    
    @IBOutlet var email : UITextField!
    @IBOutlet var password : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        email.setBottomBorder()
        password.setBottomBorder()
        
    }
    
    @IBAction func logInAuthentification(sender : Any?){
        
        if  email.text != nil && password.text != nil {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!){ User, Error in
                if Error == nil && User != nil{
                    print("User created !")
                    self.alert("Message", message: "User log In sucess")
                } else{
                    print("Error creating user : \(String(describing: Error?.localizedDescription))")
                }
            }
        } else{
            alert("Error", message: "Please fill up all fields in order to login")
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
