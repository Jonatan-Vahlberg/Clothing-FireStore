//
//  Customer.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

//Customer Model on all info except password
class Customer{
    
    var firstName: String
    var lastName: String
    var email: String
    private var dbID: String
    
    init(fn: String, ln: String, email: String, dbID: String) {
        firstName = fn
        lastName = ln
        self.email = email
        self.dbID = dbID
    }
}
