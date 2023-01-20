//
//  SignInController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 31.12.2022.
//

import UIKit

final class SignInController: UIViewController {
 
    //MARK: - Properties
    
    private let authViewModel = AuthViewModel()
    private let signInView = SignInView()
    
    //MARK: - Gettable Properties
    
    var email: String {
        signInView.emailTextField.text ?? ""
    }
    
    var password: String {
        signInView.passwordTextField.text ?? ""
    }
    
    
    
    //MARK: - ViewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegates()
        configureNavBar()
    }
    
    private func configureViewController() {
        view = signInView
        view.backgroundColor = .systemGray6
        
    }
    
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    private func setupDelegates() {
        signInView.interface = self
        authViewModel.delegate = self
    }
    
    
}

extension SignInController: SignInViewInterface {
    
    func signInView(_ view: SignInView, forgotPasswordButtonTapped button: UIButton) {
        let resetPasswordVC = ResetPasswordController()
        present(resetPasswordVC, animated: true)
    }
    func signInView(_ view: SignInView, signInButtonTapped button: UIButton) {
        authViewModel.signIn(email: email, password: password)
    }
    
    func signInView(_ view: SignInView, signUpButtonTapped button: UIButton) {
        let signUpVC = SignUpController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}

extension SignInController: AuthViewModelDelegate {
    func didOccurError(_ error: Error) {
        Alert.alertMessage(title: "\(error.localizedDescription)", message: "", vc: self)
    }
    
    func didSignUpSuccessful() {
        print("sign up succesful")
    }
    
    func didSignInSuccessful() {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    
}
