//
//  WebService.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Alamofire

protocol ServiceProtocol {
    func fetchProducts(type: AllProductsWebEndPoint ,onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ())
    func fetchCategory(onSuccess: @escaping (Categories?) -> (), onError: @escaping (AFError) -> ())
    func fetchSingleProduct(type: SingleProductWebEndPoint, onSuccess:@escaping (Product?) -> (), onError: @escaping (AFError) -> ())
    func fetchProductByCategory(type: ProductsSpecificCategoryWebEndPoint, onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ())
}

final class Service: ServiceProtocol {
    
    deinit {
        print("deinit service")
    }
    
    static let shared = Service()
    
    func fetchProducts(type: AllProductsWebEndPoint ,onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ()) {
        var url = ""
        
        switch type {
        case.fetchAllProducts:
            url = AllProductsWebEndPoint.fetchAllProducts.path
        }
        
        NetworkManager.shared.request(path: url) { (response: [Product]) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    func fetchSingleProduct(type: SingleProductWebEndPoint, onSuccess: @escaping (Product?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        var url = ""
        
        switch type {
            
        case .fetchSingleProducts(id: let id):
            url = SingleProductWebEndPoint.fetchSingleProducts(id: id).path
        }
        
        NetworkManager.shared.request(path: url) { (response: Product) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    
    func fetchCategory(onSuccess: @escaping (Categories?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        NetworkManager.shared.request(path: "https://fakestoreapi.com/products/categories") { (response: Categories) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    func fetchProductByCategory(type: ProductsSpecificCategoryWebEndPoint, onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ()) {
        var url = ""
        
        switch type {
        case .fetchProdudctByCategory(let category):
            url = ProductsSpecificCategoryWebEndPoint.fetchProdudctByCategory(category: category).path
        }
        
        NetworkManager.shared.request(path: url) { (response: [Product]) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    
}
