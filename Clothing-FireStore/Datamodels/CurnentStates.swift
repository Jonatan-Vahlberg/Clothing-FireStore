//
//  CurnentStates.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-19.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

struct CurrentStates{
    
    static var shared = CurrentStates()
    
    var catalogueState = GlobalState.none
    
    var loginState: Bool = false
    
//    func setCatalogueState(with State: GlobalState){
//    }
//    self.catalogueState = State
    
    private init(){
        
    }
}
