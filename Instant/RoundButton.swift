//
//  RoundButton.swift
//  Instant
//
//  Created by Xavier de Cazenove on 06/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    //Intialiseur
    required init?(coder aDecoder: NSCoder) {
        //Initialiseur de la classe parente
        super.init(coder: aDecoder)
        
        
        
        //Coins arrondis
        layer.cornerRadius = 5
        
        //Couleur de la bordure
        layer.borderColor = UIColor.red.cgColor
        
        //Epaisseur de la bordure
        layer.borderWidth = 2
        
        //Couleur du texte
        setTitleColor(UIColor.red, for: .normal)
        
        //Padding a gauche et a droite
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
    }
}
