//
//  HomeProfileViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 15.01.2023.
//

import Foundation
import FirebaseAuth

protocol HomeProfileViewModelDelegate: AnyObject {
    func didFetchUserInfro()
    func didGotCurrentTime()
}

final class HomeProfileViewModel {
    
    var currentHour = NSDate().getCurrentHour()
    var hiText: String?
    
    
    weak var delegate: HomeProfileViewModelDelegate?
    
    private let currentUser = Auth.auth().currentUser
    
    var email: String?
    var username: String?
    
    func fetchUser() {
        if let currentUser = currentUser {
            username = currentUser.displayName
            email = currentUser.email
            self.delegate?.didFetchUserInfro()
        }
    }
    
    //MARK: - Change hi label according to current time
    
    func getTime()  {
        
        switch currentHour {
            
        case (5 ..< 11):
            hiText = "Good Morning ☀️"
            self.delegate?.didGotCurrentTime()
        case (12 ..< 15):
            hiText = "Good Afternoon 👋"
            self.delegate?.didGotCurrentTime()
            
        case (16 ..< 22):
            hiText = "Good Evening 👋"
            self.delegate?.didGotCurrentTime()
            
        default:
            hiText = "Good Night 🌑"
            self.delegate?.didGotCurrentTime()
            
            
        }
        
    }
    
}


