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
    
    
    
    func updateCart(productId: Int) {
        guard let currentUser = currentUser else { return }
        
        let userRef = database.collection("Users").document(currentUser.uid)
        
        userRef.updateData(["\(productId)" : 5]) { error in
            if let error = error { self.delegate?.didOccurError(error) } else { self.delegate?.didUpdateCartSuccessful() }
        }
            
            
        
    }
}

