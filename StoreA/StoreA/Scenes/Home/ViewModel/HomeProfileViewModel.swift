//
//  HomeProfileViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 15.01.2023.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

protocol HomeProfileViewModelDelegate: AnyObject {
    func didFetchUserInfro()
    func didFetchProfilePhotoSuccessful(_ url: String)
    func didGotCurrentTime()
}

final class HomeProfileViewModel {
    
    var currentHour = NSDate().getCurrentHour()
    var hiText: String?
    
    
    weak var delegate: HomeProfileViewModelDelegate?
    
    private let currentUser = Auth.auth().currentUser
    
    private let storage = Storage.storage().reference()
    
    var email: String?
    var username: String?
    
    func fetchUser() {
        if let currentUser = currentUser {
            username = currentUser.displayName
            email = currentUser.email
            self.delegate?.didFetchUserInfro()
        }
    }
    
    
    func fetchProfilePhoto() {
        if let currentUser = currentUser {
            let profileImageRef = storage.child("profileImages/file.png").child(currentUser.uid)
            profileImageRef.downloadURL { [weak self] url, error in
                guard let url = url , error == nil else { return }
                let urlString = url.absoluteString
                self?.delegate?.didFetchProfilePhotoSuccessful(urlString)
            }
        }
    }
    
    //MARK: - Change hi label according to current time
    
    func getTime()  {
        
        switch currentHour {
            
        case (6 ..< 12):
            hiText = "Good Morning ☀️"
            self.delegate?.didGotCurrentTime()
        case (12 ..< 16):
            hiText = "Good Afternoon 👋"
            self.delegate?.didGotCurrentTime()
            
        case (16 ..< 22):
            hiText = "Good Evening 👋"
            self.delegate?.didGotCurrentTime()
            
        case (0..<5):
            hiText = "Good Night 🌑"
            self.delegate?.didGotCurrentTime()
            
        default:
            hiText = "Good Night 🌑"
            self.delegate?.didGotCurrentTime()
            
            
        }
        
    }
    
}


