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
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var emailLbl: UILabel!
    let storyBoardRefrence = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let user = CurrentStates.currentCustomer{
            nameLbl.text = "\(user.firstName) \(user.lastName)"
            emailLbl.text = "\(user.email)"
        }
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleMenu"), object: nil)
    }
    //attempts to wipe login from keychain and firebase"Auth"
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
