//
//  AuthViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

//MARK: - AutViewModelDelegate Protocol

protocol AuthViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didSignUpSuccessful()
    func didSignInSuccessful()
}

final class AuthViewModel {
    deinit {
        print("deinit authviewmodel")
    }
    
    weak var delegate: AuthViewModelDelegate?
    
    private let database = Firestore.firestore()
    
    //MARK: - SignUp Method
    
    func signUp(username: String ,email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                self.delegate?.didOccurError(error)
                return
            }
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                    return
                }
            }
            
            guard let uid = authDataResult?.user.uid,
                  let email = authDataResult?.user.email else { return }
            
            let cart: [Int: Int] = [:]
            let wishList: [Int: Int] = [:]
            
            let user = User(id: uid, username: username, email: email, cart: cart, wishList: wishList)
            self.database.collection("Users").document(uid).setData(user.dictionary) { error in
                if let error = error {
                    self.delegate?.didOccurError(error)
                    return
                }
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

