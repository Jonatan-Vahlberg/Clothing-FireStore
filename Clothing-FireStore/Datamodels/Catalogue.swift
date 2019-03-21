//
//  Catalogue.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-07.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation
import Firebase


class Catalogue{
    
    static let shared = Catalogue()
    
    private var itemList = Array<CatalogueItem>()
    
    func count()-> Int{
        return itemList.count
    }
    
    func get(for index: Int) -> CatalogueItem?{
        
        if index >= count() || index < 0 {
            return nil
        }
        return itemList[index]
        
    }
    
    func add(to item: CatalogueItem){
        itemList.append(item)
    }
    
//    func update(exsisting item: CatalogueItem) -> Bool{
//
//        if itemList.first({$0.id == item.id}) = item{
//
//            return true
//        }
//
//        return false
//    }
    
    func filter(using filterString: String){
        
    }
//    func filter(using filterEnum: enum){
//
//    }
    
    func getCatalogueFromDatabase(){
        let catalogueDataBase = Database.database().reference().child("Catalogue")
    
        catalogueDataBase.observe(.childAdded) { (snapshot) in
            print(snapshot.value)
            let snapValue = snapshot.value as! [String: Any?]
                
            let id = snapValue["Id"] as! Int
            print(id)
            let name = snapValue["Name"] as! String
            let description = snapValue["Description"] as! String
            let price = snapValue["Price"] as! Int
            let stock = snapValue["Stock"] as! Int
            
            let item = CatalogueItem(id: id, name: name, price: price, description: description, stock: stock)
            
            self.itemList.append(item)
        }
    }
    
    private init(){
      getCatalogueFromDatabase()
    }
}
