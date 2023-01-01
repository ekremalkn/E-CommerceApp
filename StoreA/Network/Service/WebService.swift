//
//  WebService.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Alamofire

protocol ServiceProtocol {
    func fetchProducts(onSuccess: @escaping ([Product]?) -> (), onError: @escaping (AFError) -> ())
}

final class Service: ServiceProtocol {
    static let shared = Service()
    
    func fetchProducts(onSuccess: @escaping ([Product]?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        NetworkManager.shared.request(path: "https://fakestoreapi.com/products") { (response: [Product]) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    
}
