//
//  ViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: StoryboardNavigationViewController {

    var timer = Timer()
    var time = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets up a timer for checjing database integrity in background
        timer = Timer .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkDatabaseIntegrity), userInfo: nil, repeats: true)
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.topToBottom, withFrame:self.view.frame, andColors:[UIColor.black, UIColor.purple])
    }

    
   @objc func checkDatabaseIntegrity() {
        if Catalogue.shared.count() > 0{
            //Once database has passed invalidate timer
            timer.invalidate()
            presentNextViewController(enumValue: .home)
            time += 1
        }
        else if time == 150{
                //Attemp a reconnect as exiting the app is not recomended by Apple
        }
    }


}

