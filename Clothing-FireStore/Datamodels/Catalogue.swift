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
    
    func get(ForID id: String) -> CatalogueItem?{
        let item =  itemList.filter{$0.id == id}.first
        return item
    }
    
    func getFilterdCatalogue(byCategory: Bool,value: String) -> [CatalogueItem]{
        var filteredCatalogue = [CatalogueItem]()
        
        for item in itemList{
            if byCategory{
                if item.category == value{
                    filteredCatalogue.append(item)
                }
            }
            else{
                if item.name.contains(value){
                    filteredCatalogue.append(item)
                }
            }
            
        }
        
        return filteredCatalogue
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
        let catalogueRefrence = Firestore.firestore().collection("Catalogue")
        
        catalogueRefrence.getDocuments { (documents, error) in
            if let err = error{
                print("Error getting documents:",err)
            }
            else{
                for doc in documents!.documents{
                    let docData = doc.data()
                    
                    if let name = docData["name"] as? String,
                        let id = docData["id"] as? String,
                        let price = docData["price"] as? Int,
                        let stock = docData["stock"] as? Int,
                        let desc = docData["description"] as? String,
                        let category = docData["category"] as? String{
                        let item = CatalogueItem(id: id, name: name, price: price, description: desc, stock: stock, category: category)
                        
                        self.itemList.append(item)
                    }
                    
                }
            }
            
        }
    }
        
    private init(){
      //getCatalogueFromDatabase()
    }
}
