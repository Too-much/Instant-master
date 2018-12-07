//
//  ViewController.swift
//  Instant
//
//  Created by Léonard Devincre on 28/11/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var signOut : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logOutSettingButton(sender : Any?){
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
}

