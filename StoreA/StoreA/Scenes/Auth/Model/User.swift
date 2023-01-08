//
//  User.swift
//  StoreA
//
//  Created by Ekrem Alkan on 8.01.2023.
//

import Foundation

struct User: Codable {
        var id: String?
        var username: String?
        var email: String?
        var cart: [Int : Int]?
    
}
