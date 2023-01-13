//
//  WishListViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 13.01.2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol WishListViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didUpdateWishListSuccessful()
    func didFetchProductsFromWishListSuccessful()
}

final class WishListViewModel {
    
    //MARK: - WishListViewModelDelegate

    weak var delegate: WishListViewModelDelegate?
    
    //MARK: - Properties
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    var wishListProducts: [Product] = []
    
    var wishList: [String: Int]? = [:] {
        didSet {
            guard let wishList = wishList else { return }
            if wishList.isEmpty == true {
                
            } else {
                fetchProductFromFireStoreCollection(wishList: wishList)
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
                    self.delegate?.didUpdateWishListSuccessful()
                }
            }
        } else {
            userRef.updateData(["wishList.\(productId)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                } else {
                    self.delegate?.didUpdateWishListSuccessful()
                }
            }
        }
    }
    
    //MARK: - Get Wishlist from Firestore
    
    func fetchWishList() {
        guard let currentUser = currentUser else { return }
        
        let wishListRef = database.collection("Users").document(currentUser.uid)
        wishListRef.getDocument(source: .default) { documentData, error in
            if let documentData = documentData {
                self.wishList = documentData.get("wishList") as? [String: Int]
            }
        }
    }
    
    //MARK: - Fetch Product From FirestoreCollection to wishListProducts
    
    func fetchProductFromFireStoreCollection(wishList: [String: Int]) {
        let productsRef = database.collection("products")
        
        for (id, _) in wishList {
            let product = productsRef.document(id)
            product.getDocument(as: Product.self) { result in
                switch result {
                case .failure(let error):
                    self.delegate?.didOccurError(error)
                case .success(let product):
                    guard let productId = product.id else { return }
                    if !self.wishListProducts.contains(where: { product in
                        return product.id == productId
                    }) {
                        self.wishListProducts.append(product)
                    }
                    self.delegate?.didFetchProductsFromWishListSuccessful()
                }
            }
        }
    }
    
    //MARK: - GetProductIndexPath
    
    func getProductIndexPath(productId: Int) -> IndexPath {
        let index = wishListProducts.firstIndex { product in
            product.id == productId
        }
        if let index = index {
            return IndexPath(row: index, section: 0)
        }
        return IndexPath()
    }
    
    //MARK: - RemoveProduct
    
    func removeProduct(index: Int) {
        wishListProducts.remove(at: index)
    }
    
    
    
}


