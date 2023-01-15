//
//  ProfileController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import UIKit

class ProfileController: UIViewController {

    
    //MARK: - Properties
    
    private let profileViewModel = ProfileViewModel()
    private let profileView = ProfileView()

    //MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        profileViewModel.fetchUser()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegates()
    }
    
    
    //MARK: - Configure ViewController

    private func configureViewController() {
        view.backgroundColor = .white
        view = profileView
    }

    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        profileView.interface = self
        
        profileViewModel.delegate = self
    }

    

}

//MARK: - ProfileViewInterface

extension ProfileController: ProfileViewInterface {
    func profileView(_ view: ProfileView, signOutButtonTapped button: UIButton) {
        profileViewModel.signOut()
    }
    
    
}

//MARK: - ProfileViewModelDelegate

extension ProfileController: ProfileViewModelDelegate {
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didSignOutSuccessful() {
        let signInVC = SignInController()
        navigationController?.pushViewController(signInVC, animated: true)
        Alert.alertMessage(title: "Çıkış başarılı", message: "", vc: self)
    }
    
    func didFetchUserInfo() {
        profileView.configure(email: profileViewModel.email ?? "email yok", username: profileViewModel.username ?? "kullanıcı yok")
    }
    
    
}
