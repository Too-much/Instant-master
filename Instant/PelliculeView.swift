//
//  PelliculeView.swift
//  Instant
//
//  Created by Léonard Devincre on 06/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//
import UIKit

class PelliculeView : UIButton {
    
    
    
    //initialiseur
    required init?(coder aDecoder: NSCoder) {
        //initialisateur de la classe parente
        super.init(coder : aDecoder)
        
        //Coins arrondis
        layer.cornerRadius = 5
        
        layer.borderWidth = 2
        
        layer.borderColor = UIColor.black.cgColor
        
        layer.backgroundColor = UIColor.lightGray.cgColor
        
        self.titleLabel?.textAlignment = NSTextAlignment.center
        
        //Padding a gauche et a droite
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
}
