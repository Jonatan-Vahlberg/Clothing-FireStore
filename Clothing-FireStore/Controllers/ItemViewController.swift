//
//  ItemViewController.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-14.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import UIKit
import Firebase

class ItemViewController: UIViewController {

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
            if let itemImage = UIImage(named:"item_\(item.id)"){
                imageView.image = itemImage
            }
        }
        else{
            
            
        }
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
            }
        }
                    
    }
    
    @IBAction func returnToPreviousVC(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func menuBtnPressed(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleMenu"), object: nil)
    }
    
}
