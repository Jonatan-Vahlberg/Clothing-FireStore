//
//  CatalogueItem.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

//Catalogue item class
class CatalogueItem{
    let id: String
    let name : String
    var price: Int
    var description: String
    //var special: ()-> Void?
    var stock: Int
    var category = ""
    var image = ""
    
    //from database
    init(id: String,name: String, price: Int, description: String,stock: Int, category: String) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.stock = stock
        self.category = category
        self.image = "i\(id)"
        
        
    }
    //initial init
    init(name: String, price: Int, description: String,stock: Int) {
        self.name = name
        self.price = price
        self.description = description
        self.stock = stock
        self.id = String(arc4random_uniform(900000) + 100000)
        self.image = "i\(id)"
    }
    
}
