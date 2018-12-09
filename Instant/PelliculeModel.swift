//
//  PelliculeModel.swift
//  Instant
//
//  Created by Léonard Devincre on 06/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit

class Pellicule {
    ///Variables de la classe pellicules
    var state : Bool    //state définis l'état en cours=false et terminé=true
    var nbPhotos : Int  //le nombre de photos sur la pellicule
    var nom : String    //le nom de la pellicule
    var startDate : Date    //date de début de la pellicule
    var icone : UIImage     //nom de l'icone de la pellicule (à définir...)
    
    
    //constructeur d'une pellicule
    init( _state : Bool, _nom : String, _icone : String ) {
        //initialisation des variables
        state = _state
        nbPhotos = 0    //lors de l'initialisation du pellicule, son nombre de photos est à 0
        nom = _nom
        startDate = Date.init() //prend la valeur de l'heure et la date actuelle
        icone = UIImage.init(imageLiteralResourceName: _icone)
        
    }
    
    //fonction qui indique que la pellicule est finis
    func terminatePellicule(){
        state = false
    }
    
}
