//
//  AuthViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation
import Firebase

//MARK: - AutViewModelDelegate Protocol

protocol AuthViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didSignUpSuccessful()
    func didSignInSuccessful()
}

final class AuthViewModel {
    
    weak var delegate: AuthViewModelDelegate?
    
    private let database = Database.database().reference()
    
    //MARK: - SignUp Method

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
    
    //MARK: - SignIn Method

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

