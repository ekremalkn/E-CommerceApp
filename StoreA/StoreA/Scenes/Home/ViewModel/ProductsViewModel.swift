//
//  ProductsViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation

protocol ProductsViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchAllProductsSuccessful()
    func didFetchSingleProduct(_ product: Product)
}

final class ProductsViewModel {
    
    weak var delegate: ProductsViewModelDelegate?
    
    let manager = Service.shared
    
    var allProducts: [Product] = []
    var singleProduct: Product?
    var allCategories = Categories()
    
    func fetchAllProducts() {
        manager.fetchProducts(type: .fetchAllProducts){ products in
            if let products = products {
                self.allProducts = products
                self.delegate?.didFetchAllProductsSuccessful()
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
    
    func fetchOnlyCategory() {
        manager.fetchCategory { categories in
            if let categories = categories {
                self.allCategories = categories
                self.delegate?.didFetchAllProductsSuccessful()
            }
                
        } onError: { error in
            self.delegate?.didOccurError(error)
        }

    }
    
    
    
}


