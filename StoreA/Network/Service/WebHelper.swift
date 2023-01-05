//
//  WebHelper.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation


enum WebEndPoint {
    case fetchAllProducts
    case fetchSingleProducts(String)
    case fetchCategoryProducts(String)
    
    var path: String {
        switch self {
        case .fetchAllProducts:
            return NetworkHelper.shared.requestUrl(url: "/products")
        case .fetchCategoryProducts(let category):
            return NetworkHelper.shared.requestUrl(url: "/products/category/\(category)")
        case .fetchSingleProducts(let id):
            return NetworkHelper.shared.requestUrl(url: "/products/\(id)")
        }
    }
}
