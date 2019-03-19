//
//  CurnentStates.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-19.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//

import Foundation

struct CurrentStates{
    
    static let shared = CurrentStates()
    
    var catalogueState: GlobalState = .none
    
    var loginState: Bool = false
    
    private init(){
        
    }
}
