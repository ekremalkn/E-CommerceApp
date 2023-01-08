//
//  Encodable+Dictionary.swift
//  StoreA
//
//  Created by Ekrem Alkan on 8.01.2023.
//

import Foundation

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    
    var dictionary: [String: Any] {
        let data = (try? JSON.encoder.encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
    }
    
}
