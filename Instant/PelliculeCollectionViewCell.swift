//
//  PelliculeCollectionViewCell.swift
//  Instant
//
//  Created by Léonard Devincre on 08/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//
import UIKit

class PelliculeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var cellButton: PelliculeView!
    
    func displayContent(pellicule: Pellicule) {
        if pellicule.nom == "addButton" {
            cellButton.setImage(pellicule.icone, for: .normal)
            cellButton.accessibilityIdentifier = "addButton"
        } else {
            cellButton.setImage(pellicule.icone, for: .normal)
            cellButton.accessibilityIdentifier = "normalButton"
        }
        
        
    }
    
    @IBAction func addButonAction(_ sender: Any) {
        if cellButton.accessibilityIdentifier == "addButton" {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addPellicule"), object: nil)
        }
    }
    
}
