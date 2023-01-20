//
//  ResetPasswordController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 20.01.2023.
//

import UIKit

final class ResetPasswordController: UIViewController {
    
    
    //MARK: - Properties
    
    private let resetPasswordView = ResetPasswordView()
    private let resetPasswordViewModel = ResetPasswordViewModel()
    

    
    //MARK: - Gettable properties

    var email: String {
        resetPasswordView.emailTextField.text ?? ""
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupDelegates()
    }
    
    
    //MARK: - ConfigureViewController
    
    private func configureViewController() {
        view = resetPasswordView
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        resetPasswordViewModel.delegate = self
        
        resetPasswordView.interface = self
    }


}

//MARK: - ResetPasswordViewInterface

extension ResetPasswordController: ResetPasswordViewInterface {
    
    func resetPasswordView(_ view: ResetPasswordView, resetPasswordButtonTapped button: UIButton) {
        resetPasswordViewModel.resetPassword(email)
    }
    
}


//MARK: - ResetPasswordViewModelDelegate

extension ResetPasswordController: ResetPasswordViewModelDelegate {
    func didOccurError(_ error: Error) {
        Alert.alertMessage(title: "\(error.localizedDescription)", message: "", vc: self)
    }
    
    func didResetPasswordSuccessful() {
        Alert.alertMessage(title: "Successful!", message: "A password reset emeail has been sent!", vc: self)
    }
    
    
}

