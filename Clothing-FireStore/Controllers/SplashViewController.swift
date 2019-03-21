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

    //For non logged in users will only display screen once if exsists
    let userDefaultKey = "seenScreenOnce"
    
    //refrence to NSUserDefaults
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase Database refrence
        //let catalogueDataBase = Database.database().reference()

        //TODO: - Remove wierd firebase dependency
//        catalogueDataBase.child("test").setValue("testing")
//        catalogueDataBase.observe(DataEventType.value, with:{ (snapshot) in
//            print(snapshot.value)
//            //let snapValue = snapshot.value as! [String: Any?]
//
//        })
        print(Catalogue.shared.count())
        
        //Gets current users email and password from keychain if they are logged in
//        let emailOfcurrentUser: String? = KeychainWrapper.standard.string(forKey:"currentEmail")
//        let passwordOfCurrentUser: String? = KeychainWrapper.standard.string(forKey: "currentPassword")
//        if let email = emailOfcurrentUser,
//            let password = passwordOfCurrentUser{
//            //authenticates user if a current user has been saved to KeyChain
//            Auth.auth().signIn(withEmail: email, password: password, completion: nil)
//            print("Goto home")
//            presentNextViewController(enumValue: .home)
//        }
//        else if userDefaults.value(forKey: userDefaultKey) != nil {
//            //presents home screen
//            presentNextViewController(enumValue: .home)
//        }
//        else{
//            //Sets UserDefault for seen splash screen once
//            userDefaults.set("seenItOnce", forKey: userDefaultKey)
//        }
    }
    override func viewDidAppear(_ animated: Bool) {
        let emailOfcurrentUser: String? = KeychainWrapper.standard.string(forKey:"currentEmail")
        let passwordOfCurrentUser: String? = KeychainWrapper.standard.string(forKey: "currentPassword")
        if let email = emailOfcurrentUser,
            let password = passwordOfCurrentUser{
            //authenticates user if a current user has been saved to KeyChain
            Auth.auth().signIn(withEmail: email, password: password, completion: nil)
            print("Goto home")
            presentNextViewController(enumValue: .home)
        }
        else if userDefaults.value(forKey: userDefaultKey) != nil {
            //presents home screen
            presentNextViewController(enumValue: .home)
        }
        else{
            //Sets UserDefault for seen splash screen once
            userDefaults.set("seenItOnce", forKey: userDefaultKey)
        }

    }

    // Function for segueless navigation from splash screen controllers buttons
    @IBAction func moveForward(_ sender: UIButton) {
        
        //destination Enum
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
