//
//  CartViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 12.01.2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol CartViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didUpdateCartSuccessful()
    func didFetchProductsFromCartSuccessful()
    func didFetchCostAccToItemCount()
}



final class CartViewModel {
    
    weak var delegate: CartViewModelDelegate?
    
    //MARK: - Properties
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    
    
    var cartsProducts: [Product] = [] {
        didSet {
            if cartsProducts.count == cart?.count {
                delegate?.didFetchProductsFromCartSuccessful()
            }
        }
    }
    
    private var costAccToItemCount: [String: Double] = [:] {
        didSet {
            if costAccToItemCount.count == cart?.count {
                delegate?.didFetchCostAccToItemCount()
            }
        }
    }
    
    
        var cart: [String : Int]? = [:] {
        didSet {
            guard let cart = cart else { return }
            if cart.isEmpty == true {
                costAccToItemCount = [:]
            } else {
                fetchProductFromCart(cart: cart)
                fetchCostAccToCount(cart: cart)
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
                    self.delegate?.didUpdateCartSuccessful()
                }
            }
            
        } else {
            userRef.updateData(["cart.\(productId)" : FieldValue.delete()]) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                } else {
                    self.delegate?.didUpdateCartSuccessful()
                }
            }
        }
    }
   
    //MARK: - Get Cart from Firestore
    
    func fetchCart() {
        guard let currentUser = currentUser else { return }
        
        let cartRef = database.collection("Users").document(currentUser.uid)
        cartRef.getDocument(source: .default) { documentData, error in
            if let documentData = documentData {
                self.cart = documentData.get("cart") as? [String : Int]
            }
        }
    }
    
    //MARK: - FetchCost according to ProductCount
    
    func fetchCostAccToCount(cart: [String: Int]) {
        let productsRef = database.collection("products")
        
        for (id, quantity) in cart {
            let product = productsRef.document(id)
            
            product.getDocument { result, error in
                guard let result = result else { return }
                
                if result.exists == true {
                    var cost: Double = 0
                    guard let price = result.get("price") as? Double else { return }
                    cost = price * Double(quantity)
                    self.costAccToItemCount[id, default: 0] = cost
                } else {
                    self.costAccToItemCount = [:]
                }
            }
            
        }
    }
    
    
    //MARK: - TotalCost
    
    var totalCost: Double {
        var total: Double = 0
        for (_, cost) in costAccToItemCount {
            total += cost
        }
        return total.rounded(toPlaces: 2)
    }
    
  
    //MARK: - Add products to cart
    
    func fetchProductFromCart(cart: [String:Int]) {
        let productsRef = database.collection("products")
        
        for (id, _) in cart {
            let product = productsRef.document(id)
            product.getDocument(as: Product.self) { result in
                switch result {
                case .failure(let error):
                    self.delegate?.didOccurError(error)
                case .success(let product):
                    guard let productId = product.id else { return }
                    if !self.cartsProducts.contains(where: { product in
                        return product.id == productId
                    }) {
                        self.cartsProducts.append(product)
                    }
                    self.delegate?.didFetchProductsFromCartSuccessful()
                }
            }
        }
    }
    
    //MARK: - GetProductIndexPath
    
    func getProductIndexPath(productId: Int) -> IndexPath {
        let index = cartsProducts.firstIndex { product in
                    product.id == productId
                }
                return IndexPath(row: index!, section: 0)
    }
    
    //MARK: - RemoveProduct
    
    func removeProduct(index: Int) {
        cartsProducts.remove(at: index)
    }

    
}
