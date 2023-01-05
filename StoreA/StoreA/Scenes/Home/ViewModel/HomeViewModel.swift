//
//  HomeViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchItemsSuccessful()
}

final class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    let manager = Service.shared
    
    var allProducts: [Product] = []
    var allCategories = Categories()
    
    func fetchAllProducts() {
        manager.fetchProducts(type: .fetchAllProducts){ products in
            if let products = products {
                self.allProducts = products
                self.delegate?.didFetchItemsSuccessful()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
    
    func fetchOnlyCategory() {
        manager.fetchCategory { categories in
            if let categories = categories {
                self.allCategories = categories
                self.delegate?.didFetchItemsSuccessful()
            }
                
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
    
    
    
}


