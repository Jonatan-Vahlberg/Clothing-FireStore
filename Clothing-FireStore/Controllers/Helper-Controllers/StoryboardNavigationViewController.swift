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
            identifier = "homeContainerSB"
            CurrentStates.shared.catalogueState = GlobalState.home
            break
        case .register:
            identifier = "registerSB"
            break
        case .login:
            identifier = "loginSB"
            break
        case .catalogue:
            identifier = "catalogueContainerSB"
            CurrentStates.shared.catalogueState = GlobalState.catalogue
            break
        case .item:
            identifier = "itemContainerSB"
            break
        case .cart:
            identifier = "cartContainerSB"
            break
        case .profile:
            identifier = "profileContainerSB"
            break
        default:
            identifier = "homeStoryboard"
            CurrentStates.shared.catalogueState = GlobalState.home
        }
        
        let viewController = storyBoardRefrence.instantiateViewController(withIdentifier: identifier)
        show(viewController, sender: self)
        //present(viewController, animated: true, completion: nil)
    }
    
    func showSpesificCatalogueViewController(isCategory:Bool,searchString: String){
        let viewController = storyBoardRefrence.instantiateViewController(withIdentifier: "catalogueContainerSB") as! ContainerVC
        viewController.passedData = [searchString]
    }

}
