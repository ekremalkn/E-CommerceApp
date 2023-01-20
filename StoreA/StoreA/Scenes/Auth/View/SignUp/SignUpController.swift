//
//  SignUpController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 31.12.2022.
//

import UIKit
import SnapKit

final class SignUpController: UIViewController {
 
    //MARK: - Properties
    private let authViewModel = AuthViewModel()
    private let signUpView = SignUpView()
    
    //MARK: - Gettable Properties
    
    var username: String {
        guard let username = signUpView.usernameTextField.text else { return ""}
        return username
    }
    
    var email: String {
        guard let email = signUpView.emailTextField.text else { return ""}
        return email
    }
    
    var password: String {
        guard let password = signUpView.passwordTextField.text else { return ""}
        return password
    }
    
    var confirmPassword: String {
        guard let confirmPassword = signUpView.passwordTextField.text else { return ""}
        return confirmPassword
    }
    
    //MARK: - ViewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegates()
        configureNavBar()
    }
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        view = signUpView
        
    }
    
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    private func setupDelegates() {
        signUpView.interface = self
        authViewModel.delegate = self
    }
    
    //MARK: - CheckPasswordMatch
    
    private func checkPasswordMatch() -> Bool {
        return password == confirmPassword
    }
    
}

extension SignUpController: SignUpViewInterface {
    func signUpView(_ view: SignUpView, signUpButtonTapped button: UIButton) {
        
        guard checkPasswordMatch() == true else { Alert.alertMessage(title: "Passwords do not match.", message: "", vc: self); return }
        
        authViewModel.signUp(username: username, email: email, password: password)
    }
    
    func signUpView(_ view: SignUpView, signInButtonTapped button: UIButton) {
        let signInVC = SignInController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
}

extension SignUpController: AuthViewModelDelegate {
    func didOccurError(_ error: Error) {
        Alert.alertMessage(title: "\(error.localizedDescription)", message: "", vc: self)
    }
    
    func didSignUpSuccessful() {
        Alert.alertMessage(title: "Successful!", message: "", vc: self)
        let signInVC = SignInController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func didSignInSuccessful() {
        print("sign in successful")
    }
    
}
