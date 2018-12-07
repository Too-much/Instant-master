//
//  HomeController.swift
//  Instant
//
//  Created by Léonard Devincre on 06/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet var popAddButton: UIView!
    
    var addButton : UIButton!
    
    override func viewDidLoad() {
        //a faire la fonction qui permet de récolter les infos sur les pellicules de l'utilisateur sur firebase
        //et de les initialiser sur son appli
        initAddButton()
        self.popAddButton.layer.cornerRadius = 10
    }
    
    //initialise le bouton d'ajout
    func initAddButton(){
        addButton = UIButton (frame: CGRect(x: 16, y: 186, width: 92, height: 92))
        addButton.setImage(UIImage(named: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        self.view.addSubview(addButton)
    }
    
    @objc func addButtonAction(){
        self.view.addSubview(self.popAddButton)
        self.popAddButton.center = self.view.center
        self.popAddButton.layer.cornerRadius = 5
        self.popAddButton.layer.opacity = 1
        self.popAddButton.layer.borderColor = UIColor.blue.cgColor
        self.popAddButton.layer.borderWidth = 2
    }
    
    @IBAction func closePopAddButton(_ sender: Any) {
        self.popAddButton.removeFromSuperview()
    }
}
