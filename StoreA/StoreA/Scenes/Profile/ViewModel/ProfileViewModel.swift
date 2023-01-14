//
//  ProfileViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import Foundation
import FirebaseAuth

protocol ProfileViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didSignOutSuccessful()
    func didFetchUserInfo()
}

final class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    
    private let currentUser = Auth.auth().currentUser
    
    var currentUserInfo: ProfileModel?
    
    var email: String?
    var username: String?
    
    func fetchUser() {
        if let currentUser = currentUser {
            username = currentUser.displayName
            email = currentUser.email
            self.delegate?.didFetchUserInfo()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.delegate?.didSignOutSuccessful()
        } catch {
            self.delegate?.didOccurError(error)
        }
    }
}
