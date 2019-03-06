//
//  CatalogueItem.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-06.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

class CatalogueItem{
    let name : String
    var price: Int
    var description: String
    var special: ()-> Void?
    var stock: Int
    
    init(name: String, price: Int, description: String,stock: Int, special: @escaping () -> Void ) {
        self.name = name
        self.price = price
        self.description = description
        self.stock = stock
        self.special = special
    }
    
    func prepareForDatabase() -> [String:String]{
        var dictionary = [String:String]()
        dictionary["name"] = name
        dictionary["price"] = String(price)
        dictionary["description"] = description
        dictionary["stock"] = String(stock)
        return dictionary
    }
}
