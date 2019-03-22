//
//  AppDelegate.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //For non logged in users will only display screen once if exsists
    let userDefaultKey = "seenScreenOnce"
    
    //refrence to NSUserDefaults
    let userDefaults = UserDefaults.standard
    
    let group = DispatchGroup()
    
    var identifier = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print("Reached Config")
        FirebaseApp.configure()
        print("passed Config")
        
        let emailOfcurrentUser: String? = KeychainWrapper.standard.string(forKey:"currentEmail")
        let passwordOfCurrentUser: String? = KeychainWrapper.standard.string(forKey:"currentPassword")
        
        if let email = emailOfcurrentUser,
            let password = passwordOfCurrentUser{
                //authenticates user if a current user has been saved to KeyChain
                Auth.auth().signIn(withEmail: email, password: password, completion: nil)
            identifier = "logoSB"
        }
        else if userDefaults.value(forKey: userDefaultKey) != nil {
            //presents home screen
            identifier = "logoSB"
            
        }
        else{
            //Sets UserDefault for seen splash screen once
            userDefaults.set("seenItOnce", forKey: userDefaultKey)
            identifier = "splashSB"
        }
        Catalogue.shared.getCatalogueFromDatabase()
        showInitalController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
    
    }
    
    func showInitalController(){
        if let window = self.window{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: identifier)
            window.rootViewController = vc
        }
    }


}

