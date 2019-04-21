//
//  CurnentStates.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-19.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation
import Firebase

//A Struct for keeping track of varoius Singleton objects that in turn monitor any one key function of the app
//Example currentCustomer is a database created object of the logged in customer
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
                                if let favourites = docData!["favourites"] as? [Int]{
                                    newUser.favourites = favourites
                                }
                                
                                CurrentStates.currentCustomer = newUser
                                getOrdersFromFirestore(withUID: uid)
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
func getOrdersFromFirestore(withUID uid: String){
    let userRef = Firestore.firestore().collection("Users").document(uid)
    userRef.collection("orders").getDocuments(completion: { (documents, error) in
        if let err = error {
            
        }
        else{
            for document in documents!.documents{
                let docData = document.data()
                if docData != nil{
                    let name = docData["fullName"] as! String
                    let orderNr = docData["orderNR"] as! Int
                    let finalPrice = docData["finalprice"] as! Int
                    let orderDate = docData["orderDate"] as! String
                    let finalDate = docData["finalDate"] as! String
                    let cardNr = docData["cardNR"] as! String
                    
                    let order = Order(name: name, orderNr: orderNr, orderDate: orderDate, finalDate: finalDate, finalPrice: finalPrice, cardNr: cardNr)
                    
                    CurrentStates.currentCustomer?.purchases.append(order)
                }
            }
        }
    })
}
