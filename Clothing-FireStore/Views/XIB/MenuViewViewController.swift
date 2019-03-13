//
//  MenuViewViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-11.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class MenuViewViewController: UIViewController {

    @IBOutlet var menuOptions: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        for option in menuOptions{
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.wasTapped))
            option.addGestureRecognizer(tapGestureRecognizer)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func wasTapped(_ recognizer: UITapGestureRecognizer){
        
        if let tappedView = recognizer.view{
            var destinationName = ""
            let sb = UIStoryboard(name: "Main", bundle: nil)
            switch (tappedView.tag){
            case 1:
                destinationName = "homeStoryboard"
                break
            case 2:
                destinationName = "cartSB"
                break
            case 3:
                destinationName = "catalogueSB"
                break
            case 4:
                if isUserLoggedIn(){
                    destinationName = "profileSB"
                }
                else{
                    destinationName = "loginSB"
                }
                break
            case 5:
                destinationName = "storeSB"
                break
            case 6:
                destinationName = "contactSB"
                break
            default:
                destinationName = "HomeSB"
            }
            
            
            let vc = sb.instantiateViewController(withIdentifier: destinationName) as UIViewController
            if revealViewController() != nil {
                let navController = UINavigationController(rootViewController: vc)
                self.revealViewController().present(navController, animated: true, completion: nil)
            }
            //navigationController?.pushViewController(vc, animated: true)
            //self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    private func isUserLoggedIn() -> Bool{
        
        //TODO: - FIREBASE AUTH CHECK
        return false
    }
    

    

}
