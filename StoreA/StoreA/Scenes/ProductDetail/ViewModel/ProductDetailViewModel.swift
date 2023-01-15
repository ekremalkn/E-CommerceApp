//
//  ProductDetailViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 8.01.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol ProductDetailViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didUpdateCartSuccessful(quantity: Int)
    func didFetchCartCostSuccessful(productId: Int, quantity: Int)
    func didFetchWishListSuccessful(productId: Int)
}

final class ProductDetailViewModel {
    deinit {
        print("deinit productdeteailviewmodel")
    }
        
    weak var delegate: ProductDetailViewModelDelegate?
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    var cartCost: Double?
    var wishListProduct: Product?
    
    var cart: [String: Int]? = [:]
    var wishList: [String: Int]? = [:]
    
    //MARK: - FetchCart

    func fetchCart(productId: Int) {
        guard let currentUser = currentUser else { return }
        
        let cartRef = database.collection("Users").document(currentUser.uid)
        cartRef.getDocument(source: .default) { documentData, error in
            if let documentData = documentData {
                self.cart = documentData.get("cart") as? [String: Int]
                if let cart = self.cart {
                    self.fetchProductCostInCart(productId: productId, cart: cart)
                }
            }
        }
    }
    
    func fetchProductCostInCart(productId: Int, cart: [String: Int]) {
        let productsRef = database.collection("products")
        if let quantity = cart["\(productId)"] {
            let product = productsRef.document("\(productId)")
            
            product.getDocument { documentData, error in
                guard let documentData = documentData else { return }
                guard let price = documentData.get("price") as? Double else { return }
                let roundedCost = Double(price * Double(quantity)).rounded(toPlaces: 2)
                self.cartCost = roundedCost
                self.delegate?.didFetchCartCostSuccessful(productId: productId, quantity: quantity)
            }
        } else {
            print("ürün sepette yok")
        }
    }
    
    
    //MARK: - FetchWishList
    
    func fetchWishList(productId: Int) {
        guard let currentUser = currentUser else { return }
        
        let wishListRef = database.collection("Users").document(currentUser.uid)
        wishListRef.getDocument(source: .default) { documentData, error in
            guard let documentData = documentData else { return }
            self.wishList = documentData.get("wishList") as? [String: Int]
            if let wishList = self.wishList {
                for (id, _) in wishList {
                    if id == String(productId) {
                        self.delegate?.didFetchWishListSuccessful(productId: productId)
                    } else {
                        print("bu ürün wishlist'te yok")
                    }
                }
            }
            
        }
    }

    //MARK: - Update Cart in Firestore
    
    func updateCart(productId: Int, quantity: Int) {
        guard let currentUser = currentUser else { return }
        
        let userRef = database.collection("Users").document(currentUser.uid)
        
        if quantity > 0 {
            userRef.updateData(["cart.\(productId)" : quantity]) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                } else {
                    self.delegate?.didUpdateCartSuccessful(quantity: quantity)
                }
            }
        } else {
            userRef.updateData(["cart.\(productId)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                } else {
                    self.delegate?.didUpdateCartSuccessful(quantity: 0)
                }
            }
        }
      
    }
    


}

