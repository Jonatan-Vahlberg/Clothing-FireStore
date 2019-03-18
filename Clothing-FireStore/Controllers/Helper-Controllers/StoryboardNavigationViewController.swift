//
//  StoryboardNavigationViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-17.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class StoryboardNavigationViewController: UIViewController {
    
    let storyBoardRefrence = UIStoryboard(name: "Main", bundle: nil)

    func presentNextViewController(enumValue: StoryboardEnum){
        
        
        var identifier = ""
        switch enumValue{
        case .home:
            identifier = "homeStoryboard"
            break
        case .register:
            identifier = "registerSB"
            break
        case .login:
            identifier = "loginSB"
            break
        case .catalogue:
            identifier = "catalogueSB"
            break
        case .item:
            identifier = "itemSB"
            break
        case .cart:
            identifier = "cartSB"
            break
        case .profile:
            identifier = "profileSB"
            break
        default:
            identifier = "homeStoryboard"
        }
        let viewController = storyBoardRefrence.instantiateViewController(withIdentifier: identifier)
        present(viewController, animated: true, completion: nil)
    }

}
