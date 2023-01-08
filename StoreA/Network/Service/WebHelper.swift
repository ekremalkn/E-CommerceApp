//
//  WebHelper.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation


enum AllProductsWebEndPoint {
    case fetchAllProducts
    
    var path: String {
        switch self {
        case .fetchAllProducts:
            return NetworkHelper.shared.requestUrl(url: "/products")
        }
    }
}

enum SingleProductWebEndPoint {
    case fetchSingleProducts(id: Int)
    
    var path: String {
        switch self {
        case .fetchSingleProducts(let id):
            return NetworkHelper.shared.requestUrl(url: "/products/\(id)")
        }
    }
}
