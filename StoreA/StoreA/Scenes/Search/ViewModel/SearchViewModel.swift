//
//  SearchViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchFilteredItemsSuccessful()
}

final class SearchViewModel {
    deinit {
        print("deinit searchviewmodel")
    }
    
    weak var delegate: SearchViewModelDelegate?
    
    let manager = Service.shared
    
    var allProducts = [Product]()
    
    func fetchAllProducts() {
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products {
                self.allProducts = products
                self.delegate?.didFetchFilteredItemsSuccessful()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
}
