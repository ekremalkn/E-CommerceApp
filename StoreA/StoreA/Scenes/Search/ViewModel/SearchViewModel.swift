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
    func didFetchSingleProduct(_ product: Product)
}

final class SearchViewModel {
    deinit {
        print("deinit searchviewmodel")
    }
    
    weak var delegate: SearchViewModelDelegate?
    
    let manager = Service.shared
    
    var allProducts = [Product]()
    var singleProduct: Product?
    
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
    
    func fetchSingleProduct(productId id: Int) {
        manager.fetchSingleProduct(type: .fetchSingleProducts(id: id)) { product in
            if let product = product {
                self.singleProduct = product
                self.delegate?.didFetchSingleProduct(product)
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
}
