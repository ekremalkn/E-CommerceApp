//
//  SearchViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import Foundation


protocol SearchViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchSearchProductsSuccessful()
    func didFetchSingleProduct(_ product: Product)
    func didFetchProductsByCategorySuccessful()
}

final class SearchViewModel {
    deinit {
        print("deinit searchviewmodel")
    }
    
    //MARK: - SearchViewModelDelegate
    
    weak var delegate: SearchViewModelDelegate?
    
    //MARK: - Properties
    
    let manager = Service.shared
    
    
    //MARK: - Products
    
    var products: [Product] = []
    var singleProduct: Product?
    var allCategories = Categories()
    
    
    func fetchAllProducts() {
        manager.fetchProducts(type: .fetchAllProducts) { products in
            if let products = products {
                self.products = products
                self.delegate?.didFetchSearchProductsSuccessful()
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
    
    
    func fetchProductByCagetory(_ category: String) {
        manager.fetchProductByCategory(type: .fetchProdudctByCategory(category: category)) { products in
            if let products = products {
                self.products = products
                self.delegate?.didFetchProductsByCategorySuccessful()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
            
        }
        
    }
    
    
}
