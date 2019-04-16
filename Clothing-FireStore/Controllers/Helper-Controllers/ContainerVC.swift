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
    var passedData: [Any]?
    
    var sideMenuOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleMenu), name: Notification.Name("toggleMenu"), object: nil)
    }
    
    @objc func toggleMenu(){
        if sideMenuOpen{
            
            menuXConstraint.constant = -245
            
        }
        else{
            menuXConstraint.constant = 0
            
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        sideMenuOpen = !sideMenuOpen
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerToItem"{
            let vc = segue.destination as! ItemViewController
            
            guard let item = passedData?.first as? CatalogueItem else{
                return
            }
            vc.catalogueItem = item
            print(item.name)
        }
        else if segue.identifier == "goToCategory"{
            let vc = segue.destination as! FilterdCatalogueViewController
            
            guard let searchString = passedData?.first as? String else{
                return
            }
            
        }
    }

    

}
