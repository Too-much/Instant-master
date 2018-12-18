//
//  historiqueControllerViewController.swift
//  Instant
//
//  Created by Xavier de Cazenove on 17/12/2018.
//  Copyright © 2018 Léonard Devincre. All rights reserved.
//

import UIKit
import Firebase

class HistoricController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var historicCollectionView: UICollectionView!
    var user : UserProfile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadDataUser()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.tabHistoric.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! HistoricViewCell
        cell.displayContent(homeController: self,pellicule: self.user.tabHistoric[indexPath.row], pell_name: self.user.tabHistoric[indexPath.row].nom, pell_initDate: self.user.tabHistoric[indexPath.row].startDate)
        return cell
    }
    
    @objc func reloadDataUser(){
        self.user = UserProfile(db: Firestore.firestore(), id : (Auth.auth().currentUser?.uid)!)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHistoricCollectionView), name: NSNotification.Name("reloadHistoricCollectionView") , object: nil)
    }
    
    @objc func reloadHistoricCollectionView(){
        self.historicCollectionView.reloadData()
    }
}
