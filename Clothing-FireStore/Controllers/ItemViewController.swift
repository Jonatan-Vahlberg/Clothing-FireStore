//
//  ItemViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-14.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase

class ItemViewController: StoryboardNavigationViewController {

    var catalogueItem: CatalogueItem?
    var cart: [String:Int] = [String:Int]()

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = Auth.auth().currentUser?.uid{
            let userDb = Firestore.firestore().collection("Users").document(username)
            userDb.getDocument{ (document, err) in
                if let document = document, document.exists{
                    let docData = document.data()
                    if let cartData = docData!["Cart"] as? [String:Int]{
                        print(cartData)
                        if cartData != nil{
                            for (key,value) in cartData{
                                print("Key\(key) = \(value)")
                                self.cart[key] = value
                                
                            }
                        }
                        
                    }
                 }
                else{
                     print("Error in getting Document: \(err)")
                }
            }
            
        }
        
        if let item = catalogueItem {
            nameLabel.text = item.name
            priceLabel.text = " \(item.price) kr"
            if let itemImage = UIImage(named:"i\(item.id)"){
                imageView.image = itemImage
            }
        }
        else{
            
            
        }
    }

    @IBAction func goToCart(_ sender: UIBarButtonItem) {
        presentNextViewController(enumValue: .cart)
    }
    @IBAction func addToCartPressed(_ sender: UIButton) {
        if let  username = Auth.auth().currentUser?.uid{
            
            let db = Firestore.firestore()
            let userRefrence = db.collection("Users").document(username)
            if let item = catalogueItem{
                if cart.isEmpty{
                    cart[String(item.id)] = 1
                    userRefrence.setData(["Cart": cart ], merge: true)
                }
                else if let val = cart[String(item.id)] {
                    
                    cart[String(item.id)] = val + 1
                    userRefrence.setData(["Cart": cart], merge: true)
                }
                else{
                    cart[String(item.id)] = 1
                    userRefrence.setData(["Cart": cart], merge: true)
                }
                CurrentStates.shared.getCurrentCustomer(fromDatabase: true)
            }
        }
        else{
            let alert = UIAlertController(title: "Unable to place in cart", message: "Due to not being logged in the item can't be added to cart", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "Login/Register", style: .default, handler: { (action) in
                self.presentNextViewController(enumValue: .login)
            })
            let notNowAction = UIAlertAction(title: "Not Now", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(loginAction)
            alert.addAction(notNowAction)
            present(alert, animated: true, completion: nil)
        }
                    
    }
    
    @IBAction func returnToPreviousVC(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func menuBtnPressed(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleMenu"), object: nil)
    }
    
}
