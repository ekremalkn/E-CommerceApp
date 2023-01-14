//
//  ProductsViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

protocol ProductsViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchAllProductsSuccessful()
    func didFetchAllCategories()
    func didFetchProductsByCategorySuccessful()
    func didFetchSingleProduct(_ product: Product)
    func didUpdateWishListSuccessful(productId: Int)
}

final class ProductsViewModel {
    
    deinit {
        print("deinit ProductsViewModel")
    }
    weak var delegate: ProductsViewModelDelegate?
    
    let manager = Service.shared
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    var allProducts: [Product] = []
    var productsByCategory: [Product] = []
    var singleProduct: Product?
    var allCategories = Categories()
    
    var wishList: [String: Int]? = [:]
    
    func fetchAllProducts() {
        manager.fetchProducts(type: .fetchAllProducts){ products in
            if let products = products {
                self.allProducts = products.shuffled()
                self.productsByCategory = products
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
                self.delegate?.didFetchAllCategories()
            }
            
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
        
    }
    
    func fetchProductByCategory(_ category: String) {
        manager.fetchProductByCategory(type: .fetchProdudctByCategory(category: category)) { products in
            if let products = products {
                self.productsByCategory = products
                self.delegate?.didFetchProductsByCategorySuccessful()
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
    
    //MARK: - Update WishList in Firestore
    
    func updateWishList(productId: Int, quantity: Int) {
        guard let currentUser = currentUser else { return }
        
        let userRef = database.collection("Users").document(currentUser.uid)
        
        if quantity > 0 {
            userRef.updateData(["wishList.\(productId)" : quantity]) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                } else {
                    self.delegate?.didUpdateWishListSuccessful(productId: productId)
                }
            }
        } else {
            userRef.updateData(["wishList.\(productId)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                } else {
                    self.delegate?.didUpdateWishListSuccessful(productId: productId)
                }
            }
        }
    }
   
}
