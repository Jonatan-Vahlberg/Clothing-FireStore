//
//  CurnentStates.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-19.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation
import Firebase

struct CurrentStates{
    
    static var shared = CurrentStates()
    
    var catalogueState = GlobalState.none
    
    static var currentCustomer: Customer?
    
    var loginState: Bool = false
    
//    func setCatalogueState(with State: GlobalState){
//    }
//    self.catalogueState = State
    
    private init(){
        
    }
    
    func getCurrentCustomer(fromDatabase: Bool = false){
        
        if fromDatabase{
            if let uid = Auth.auth().currentUser?.uid{
                let userRef = Firestore.firestore().collection("Users").document(uid)
                
                userRef.getDocument(completion: { (document, error) in
                    if let doc = document, doc.exists{
                        let docData = doc.data()
                        if docData != nil{
                            if let fName = docData!["firstName"] as? String,
                            let lName = docData!["lastName"] as? String,
                            let email = docData!["email"] as? String{
                                
                                let newUser = Customer(fn: fName, ln: lName, email: email, dbID: uid)
                                
                                if let cart  = docData!["Cart"] as? [String:Int]{
                                    newUser.cart = cart
                                    
                                }
                                if let purchases = docData!["previousPurchases"] as? [String]{
                                    newUser.purchases = purchases
                                }
                                if let favourites = docData!["favourites"] as? [Int]{
                                    newUser.favourites = favourites
                                }
                                
                                print("USER Downloaded",newUser.cart)
                                CurrentStates.currentCustomer = newUser
                        }
                        
                        }
                    }
                })
            }
            
        }
        else{
            CurrentStates.currentCustomer = Customer()
        }
    }
}
