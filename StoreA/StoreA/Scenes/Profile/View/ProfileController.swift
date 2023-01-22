//
//  ProfileController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import UIKit

final class ProfileController: UIViewController {
    
    //MARK: - Properties
    
    private let profileViewModel = ProfileViewModel()
    private let profileView = ProfileView()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        profileViewModel.fetchUser()
        profileViewModel.fetchProfilePhoto()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavBar()
        setupDelegates()
    }
    
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        view.backgroundColor = .white
        view = profileView
    }
    
    
    private func configureNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        profileView.interface = self
        
        profileViewModel.delegate = self
    }
    
    
    
}

//MARK: - ProfileViewModelDelegate

extension ProfileController: ProfileViewModelDelegate {
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didSignOutSuccessful() {
        let signInVC = SignInController()
        signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: true)
        
    }
    
    func didFetchUserInfo() {
        profileView.configure(email: profileViewModel.email ?? "email yok", username: profileViewModel.username ?? "kullanıcı yok")
    }
    
    func didUploadProfilePhotoSuccessful() {
        profileViewModel.fetchProfilePhoto()
    }
    
    func didFetchProfilePhotoSuccessful(_ url: String) {
        profileView.profileImageView.downloadSetImage(url: url)
        profileView.profileImageActivityIndicator.stopAnimating()
    }
    
    
    
}


//MARK: - ProfileViewInterface

extension ProfileController: ProfileViewInterface {
    
    func profileView(_ view: ProfileView, signOutButtonTapped button: UIButton) {
        profileViewModel.signOut()
    }
    
    func profileView(_ view: ProfileView, addProfileButtonTapped button: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func profileView(_ view: ProfileView, resetPasswordButtonTapped button: UIButton) {
        let resetPasswordVC = ResetPasswordController()
        present(resetPasswordVC, animated: true)
    }
    
}

//MARK: - Profile Photo picker

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileView.activiyIndicator.stopAnimating()
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        guard let imageData = image.pngData() else { return }
        
        profileViewModel.uploadImageDataToFirebaseStorage(imageData)
        profileView.profileImageActivityIndicator.startAnimating()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
