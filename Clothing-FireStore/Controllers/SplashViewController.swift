//
//  SplashViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase


class SplashViewController: StoryboardNavigationViewController {

    
    let userDefaultKey = "seenScreenOnce"
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let catalogueDataBase = Database.database().reference()

        catalogueDataBase.child("test").setValue("testing")
        catalogueDataBase.observe(DataEventType.value, with:{ (snapshot) in
            print(snapshot.value)
            //let snapValue = snapshot.value as! [String: Any?]

        })
        //print(Catalogue.shared.count())
        let emailOfcurrentUser: String? = KeychainWrapper.standard.string(forKey:"currentEmail")
        let passwordOfCurrentUser: String? = KeychainWrapper.standard.string(forKey: "currentPassword")
        if let email = emailOfcurrentUser,
            let password = passwordOfCurrentUser{
            
            Auth.auth().signIn(withEmail: email, password: password, completion: nil)
            print(Auth.auth().currentUser?.uid)
            presentNextViewController(enumValue: .home)
        }
        else if userDefaults.value(forKey: userDefaultKey) != nil {
          //presentNextViewController(enumValue: .home)
        }
        else{
            userDefaults.set("seenItOnce", forKey: userDefaultKey)
        }
    }

    
    @IBAction func moveForward(_ sender: UIButton) {
        var enumValue = StoryboardEnum.home
        switch sender.tag{
        case 1:
            enumValue = .register
            break
        case 2:
           enumValue = .login
            break
        case 3:
            enumValue = .home
            break
        default:
            enumValue = .home
            break
        }
        presentNextViewController(enumValue: enumValue)
    }
    

    
}
