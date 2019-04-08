//
//  ContainerVC.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-04-05.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    @IBOutlet var menuXConstraint: NSLayoutConstraint!
    
    var sideMenuOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(toggleMenu), name: Notification.Name("toggleMenu"), object: nil)
    }
    
    @objc func toggleMenu(){
        if sideMenuOpen{
            
            menuXConstraint.constant = -245
            print("Slide Out")
        }
        else{
            menuXConstraint.constant = 0
            print("Slide In")
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        sideMenuOpen = !sideMenuOpen
    }

    

}
