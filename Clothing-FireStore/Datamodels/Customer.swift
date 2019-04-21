//
//  Customer.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

//Customer Model on all info except password
//Legacy Customer Object ("SUBJECT TO CHANGE")
class Customer{
    
    var firstName: String
    var lastName: String
    var email: String
    private var dbID: String
    
    var cart: [String:Int]?
    var purchases = [Order]()
    var favourites: [Int]?
    
    
    
    init(fn: String, ln: String, email: String, dbID: String) {
        firstName = fn
        lastName = ln
        self.email = email
        self.dbID = dbID
    }
    init() {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.dbID = ""
    }
}
