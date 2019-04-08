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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkDatabaseIntegrity), userInfo: nil, repeats: true)
        self.view.backgroundColor = UIColor(gradientStyle:UIGradientStyle.topToBottom, withFrame:self.view.frame, andColors:[UIColor.black, UIColor.purple])
    }

    
   @objc func checkDatabaseIntegrity() {
        if Catalogue.shared.count() > 0{
            timer.invalidate()
            presentNextViewController(enumValue: .home)
            
        }
    }


}

