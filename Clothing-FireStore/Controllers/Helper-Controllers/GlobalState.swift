//
//  GlobalState.swift
//  Clothing-FireStore
//
//  Created by ZOG-II on 2019-03-19.
//  Copyright © 2019 Jonatan Vahlberg. All rights reserved.
//


//Enum for apps global state or what part of the app the user is accessing
enum GlobalState{
    
    case none
    
    case home
    
    case catalogue
    
    case category(type: String)
    
    case searched(string: String)
    
    func get() -> String{
        switch self{
        case .category(let type):
            return type
        case .searched(let searched):
            return searched
        default:
            return ""
        }
    }
}
