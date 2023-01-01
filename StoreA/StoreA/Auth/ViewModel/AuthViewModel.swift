//
//  AuthViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation
import Firebase

protocol AuthViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didSignUpSuccessful()
    func didSignInSuccessful()
}

final class AuthViewModel {
    
    weak var delegate: AuthViewModelDelegate?
    
    private let database = Database.database().reference()
    
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authData, error in
            
            if let error = error {
                self.delegate?.didOccurError(error)
                return
            } else {
                self.delegate?.didSignUpSuccessful()
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
            
            if let error = error {
                self.delegate?.didOccurError(error)
                return
            } else {
                self.delegate?.didSignInSuccessful()
            }
        }
    }
}

