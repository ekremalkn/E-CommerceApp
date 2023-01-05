//
//  WebService.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Alamofire

protocol ServiceProtocol {
    func fetchProducts(type: WebEndPoint ,onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ())
    func fetchCategory(onSuccess: @escaping (Categories?) -> (), onError: @escaping (AFError) -> ())
}

final class Service: ServiceProtocol {
    
    
    static let shared = Service()
    
    func fetchProducts(type: WebEndPoint ,onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ()) {
        var url = ""
        
        switch type {
        case.fetchAllProducts:
            url = WebEndPoint.fetchAllProducts.path
        case .fetchSingleProducts(let id):
            url = WebEndPoint.fetchSingleProducts(id).path
        case .fetchCategoryProducts(let category):
            url = WebEndPoint.fetchCategoryProducts(category).path
        }
        
        NetworkManager.shared.request(path: url) { (response: [Product]) in
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
    
    
}
