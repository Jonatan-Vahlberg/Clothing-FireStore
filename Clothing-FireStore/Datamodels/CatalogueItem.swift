//
//  CatalogueItem.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

class CatalogueItem{
    let id: Int
    let name : String
    var price: Int
    var description: String
    //var special: ()-> Void?
    var stock: Int
    
    //from database
    init(id: Int,name: String, price: Int, description: String,stock: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.stock = stock
        
    }
    //initial init
    init(name: String, price: Int, description: String,stock: Int) {
        self.name = name
        self.price = price
        self.description = description
        self.stock = stock
        self.id = Int(arc4random_uniform(900000) + 100000)
        
    }
    
}
