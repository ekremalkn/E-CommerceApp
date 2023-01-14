//
//  SpecialProductsViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import Foundation


protocol SpecialProductsViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchSpecialProductsSuccessful()
    func didFetchSingleProduct(_ product: Product)
}
final class SpecialProductsViewModel {
    
    deinit {
        print("deinit SpecialProductsViewModel")
    }

    weak var delegate: SpecialProductsViewModelDelegate?
    
    let manager = Service.shared
    
    var singleProduct: Product?
    var specialProducts: [Product] = []
    
    
    func fetchSpecialProducts() {
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products {
                self.specialProducts = products.shuffled()
                self.delegate?.didFetchSpecialProductsSuccessful()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
    
    
    func fetchSingleProduct(_ productId: Int) {
        manager.fetchSingleProduct(type: .fetchSingleProducts(id: productId)) { product in
            if let product = product {
                self.singleProduct = product
                self.delegate?.didFetchSingleProduct(product)
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
    
}
