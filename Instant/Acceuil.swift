//
//  Acceuil.swift
//  Instant
//
//  Created by Xavier de Cazenove on 06/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit
import Firebase

class Acceuil: UIViewController {
    
    @IBAction func lunchLogInViewController(_ sender: Any) {
        //On récupère Main.storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //On crée une instance d'acceuil à partir du storyboard
        let acceuil = storyboard.instantiateViewController(withIdentifier: "login") as! LogIn
        //On montre le nouveau controller
        navigationController?.show(acceuil, sender: self)
    }
    
    @IBAction func lunchSignUpViewController(_ sender: Any) {
        //On récupère Main.storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //On crée une instance d'acceuil à partir du storyboard
        let acceuil = storyboard.instantiateViewController(withIdentifier: "subscribe") as! SignUp
        //On montre le nouveau controller
        navigationController?.show(acceuil, sender: self)
    }
}
