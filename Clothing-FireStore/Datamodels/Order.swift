//
//  Order.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-04-15.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

//LEGACY ORDER STRUCT MOSTLY UNUSED (SUBJECT OF DELETION IN FUTURE)
struct Order{
    
    var orderNr = 0
    var name = ""
    var orderDate = ""
    var finalDate = ""
    var price = 0
    var cardNr = ""
    
    init(name: String, orderNr: Int, orderDate: String, finalDate: String, finalPrice: Int, cardNr: String){
        self.name = name
        self.orderNr = orderNr
        self.orderDate = orderDate
        self.finalDate = finalDate
        self.price = finalPrice
        self.cardNr = cardNr
    }
}
