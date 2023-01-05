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
    
    var email: String {
        signUpView.emailTextField.text ?? ""
    }
    
    var password: String {
        signUpView.passwordTextField.text ?? ""
    }
    
    var confirmPassword: String {
        signUpView.confirmPasswordTextField.text ?? ""
    }

    //MARK: - ViewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - Configure ViewController

    private func configureViewController() {
        view = signUpView
        signUpView.interface = self
        authViewModel.delegate = self
    }
    
    //MARK: - CheckPasswordMatch
    
    private func checkPasswordMatch() -> Bool {
        return password == confirmPassword
    }

}

extension SignUpController: SignUpViewInterface {
    func signUpView(_ view: SignUpView, didTapSignUpButton button: UIButton) {
        
        guard checkPasswordMatch() == true else { return }
        
        authViewModel.signUp(email: email, password: password)
    }
    
    func signUpView(_ view: SignUpView, didTapSignInButton button: UIButton) {
        let signInVC = SignInController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
}

extension SignUpController: AuthViewModelDelegate {
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
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
