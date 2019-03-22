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
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
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
