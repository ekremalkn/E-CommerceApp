//
//  SignInController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 31.12.2022.
//

import UIKit

final class SignInController: UIViewController {
    deinit {
        print("deinit signin controller")
    }
    
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
        view.backgroundColor = .systemGray6
        configureViewController()
    }
    
    private func configureViewController() {
        view = signInView
        signInView.interface = self
        authViewModel.delegate = self
    }
    
}

extension SignInController: SignInViewInterface {
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
        print(error.localizedDescription)
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
