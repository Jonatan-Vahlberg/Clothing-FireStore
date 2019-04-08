//
//  MenuTableViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-04-08.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    
    let storyBoardRefrence = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

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
            CurrentStates.shared.catalogueState = GlobalState.home
        }
        
        let viewController = storyBoardRefrence.instantiateViewController(withIdentifier: identifier)
        show(viewController, sender: self)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            presentNextViewController(enumValue: .home)
            break;
        case 1:
            presentNextViewController(enumValue: .cart)
            break;
        case 2:
            presentNextViewController(enumValue: .catalogue(""))
            break;
        case 1:
            //Discount presentNextViewController(enumValue: .discount)
            print("discount")
            break;
        case 3:
            if userIsLogedIn(){
                presentNextViewController(enumValue: .profile)
            }
            else{
                presentNextViewController(enumValue: .login)
            }
            break;
        case 4:
            presentNextViewController(enumValue: .home)
            break;
        case 5:
            presentNextViewController(enumValue: .home)
            break;
        default:
            presentNextViewController(enumValue: .home)
            break;
        }
        
    }
    
    func userIsLogedIn() -> Bool{
        return false
    }

}
