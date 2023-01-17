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

enum ProductsSpecificCategoryWebEndPoint {
    case fetchProdudctByCategory(category: String)
    var path: String {
        switch self {
        case .fetchProdudctByCategory(let category):
            return NetworkHelper.shared.requestUrl(url: "/products/category/\(category)")
        }
    }
    
}

enum ProductCategory {
    case electronics
    case jewelery
    case mensclothing
    case womensclothing
}
 
