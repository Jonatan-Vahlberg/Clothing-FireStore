//
//  ProfileViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-04-14.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {

    let storyBoardRefrence = UIStoryboard(name: "Main", bundle: nil)
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleMenu"), object: nil)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
        }catch{
            print("Error Loging out User")
        }
        KeychainWrapper.standard.removeAllKeys()
        CurrentStates.currentCustomer = Customer()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func goToDetail(type: String){
        let identifier = "profileDetailSB"
        
        let viewController = storyBoardRefrence.instantiateViewController(withIdentifier: identifier) as! DetailViewController
        viewController.typeName = type
        show(viewController, sender: self)
    }
    
    @IBAction func goToOrders(_ sender: Any) {
        goToDetail(type: "Orders")
    }

}
