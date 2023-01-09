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
    func didUpdateCartSuccessful()
}

final class ProductDetailViewModel {
    
    weak var delegate: ProductDetailViewModelDelegate?
    
    private let database = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser
    
    
    
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
}

