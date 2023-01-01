//
//  HomeViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchProductsSuccesful()
}

final class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    let manager = Service.shared
    
    var allProducts = [Product]()
    
    func fetchAllProducts() {
        manager.fetchProducts { products in
            if let products = products {
                self.allProducts = products
                self.delegate?.didFetchProductsSuccesful()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
    
}


