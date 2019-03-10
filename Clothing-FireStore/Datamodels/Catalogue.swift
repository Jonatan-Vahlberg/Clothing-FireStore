//
//  Catalogue.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-07.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

class Catalogue{
    
    private var itemList = Array<CatalogueItem>()
    
    func count()-> Int{
        return itemList.count
    }
    
    func get(for index: Int) -> CatalogueItem{
        return itemList[index]
    }
    
    func add(to item: CatalogueItem){
        itemList.append(item)
    }
}
