//
//  CartViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 12.01.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


protocol CartViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didUpdateCartSuccessful()
    func didFetchProductsFromCartSuccessful()
    func didFetchCartCountSuccessful()
    func didFetchSingleProduct(_ product: Product)
    func didFetchCostAccToItemCount()
    func didCheckoutSuccessful()
    func didCheckoutNotSuccessful()
}

final class CartViewModel {
   
    deinit {
        print("CartViewModel deinit")
    }
    //MARK: - CartViewModelDelegate
    
    weak var delegate: CartViewModelDelegate?
    
    //MARK: - Properties
    
    let manager = Service.shared
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    var singleProduct: Product?
        
    var cartsProducts: [Product] = [] {
        didSet {
            if cartsProducts.count == cart?.count {
                delegate?.didFetchProductsFromCartSuccessful()
            }
        }
    }
    
     var costAccToItemCount: [String: Double] = [:] {
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
                cartsProducts = []
            } else {
                fetchProductFromFirestoreCollection(cart: cart)
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
    

    //MARK: - Checkout
    
    func checkout() {
        guard let currentUser = currentUser else { return }
        
        let userRef = database.collection("Users").document(currentUser.uid)
        if cartsProducts.count == 0 {
            self.delegate?.didCheckoutNotSuccessful()
        } else {
            for product in cartsProducts {
                if let productId = product.id {
                    userRef.updateData(["cart.\(productId)" : FieldValue.delete()]) { error in
                        if let error = error {
                            self.delegate?.didOccurError(error)
                        } else {
                            self.cartsProducts = []
                            self.delegate?.didUpdateCartSuccessful()
                            self.delegate?.didCheckoutSuccessful()
                        }
                    }
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
                self.delegate?.didFetchCartCountSuccessful()
            }
        }
    }
    
    //MARK: - FetchCost according to ProductCount
    
    func fetchCostAccToCount(cart: [String: Int]) {
        let productsRef = database.collection("products")
        
        for (id, quantity) in cart {
            let product = productsRef.document(id)
            
            product.getDocument { documentData, error in
                guard let documentData = documentData  else { return }
                
                if documentData.exists == true {
                    var cost: Double = 0
                    guard let price = documentData.get("price") as? Double else { return }
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
    
    
    //MARK: - Fetch Product From FirestoreCollection to cartsProducts
    
    func fetchProductFromFirestoreCollection(cart: [String:Int]) {
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
                }
            }
        }
    }
    
    //MARK: - FetchSingleProduct
    
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

    
    //MARK: - GetProductIndexPath
    
    func getProductIndexPath(productId: Int) -> IndexPath {
        let index = cartsProducts.firstIndex { product in
            product.id == productId
        }
        if let index = index {
            return IndexPath(row: index, section: 0)
        }
        return IndexPath()
    }
    
    
    //MARK: - RemoveProduct
    
    func removeProduct(index: Int, productId: String) {
        cartsProducts.remove(at: index)
        costAccToItemCount.removeValue(forKey: productId)
    }
    
    
    
}
