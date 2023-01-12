//
//  ProductsViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol ProductsViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchAllProductsSuccessful()
    func didFetchSingleProduct(_ product: Product)
}

final class ProductsViewModel {
    
    weak var delegate: ProductsViewModelDelegate?
    
    let manager = Service.shared
    
    private let database = Firestore.firestore()
    
    var allProducts: [Product] = []
    var singleProduct: Product?
    var allCategories = Categories()
    
    func fetchAllProducts() {
        manager.fetchProducts(type: .fetchAllProducts){ products in
            if let products = products {
                self.allProducts = products
                self.allProductsToFirestore(products: products)
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
    
    func allProductsToFirestore(products: [Product]?) {
        guard let products = products else { return }
        
        products.forEach { product in
            guard let id = product.id else { return }
            database.collection("products").document("\(id)").setData(product.dictionary) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                }
            }
            
        }
    }
    
    
    
}


