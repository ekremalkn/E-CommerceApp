//
//  SignUpView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import UIKit
import SnapKit

//MARK: - SignUpViewInterface Protocol

protocol SignUpViewInterface: AnyObject {
    func signUpView(_ view: SignUpView, signUpButtonTapped button: UIButton)
    func signUpView(_ view: SignUpView, signInButtonTapped button: UIButton)
} 

final class SignUpView: UIView {
    deinit {
        print("deinit signup view")
    }
    
    weak var interface: SignUpViewInterface?
    
    //MARK: - Creating UI Elements
    
    private var titleLabel = CustomLabel(text: "SignUp", numberOfLines: 0, font: .boldSystemFont(ofSize: 45), textColor: .blue, textAlignment: .left)
    private var descLabel = CustomLabel(text: "Sign up to exploring our amazing products.", numberOfLines: 0, font: .systemFont(ofSize: 20), textColor: .systemGray, textAlignment: .left)
    private var labelStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 20, isHidden: false)
    var usernameTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "person")!)
    var emailTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "envelope")!)
    var passwordTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "lock")!)
    var confirmPasswordTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "lock")!)
    private var signUpButton = OnboardingButton(title: "Sign Up", titleColor: .white, font: .boldSystemFont(ofSize: 19), backgroundColor: .blue, cornerRadius: 16)
    private var textFieldButtonStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 25, isHidden: false)
    private var signInLabel = CustomLabel(text: "Already have an account?", numberOfLines: 1, font: .systemFont(ofSize: 18), textColor: .systemGray, textAlignment: .center)
    private var signInButton = OnboardingButton(title: "Sign In", titleColor: .systemOrange, font: .systemFont(ofSize: 15), backgroundColor: .systemGray6, cornerRadius: 16)
    private var signInStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 5, isHidden: false)
    
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubviews()
        setupConstraints()
        addLabelsToStackView()
        addTextFieldsToStackView()
        addSignInElementsStackView()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Button Actions
    
    private func addTarget() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signInButtonTapped(_ button: UIButton) {
        interface?.signUpView(self, signInButtonTapped: button)
    }
    
    @objc private func signUpButtonTapped(_ button: UIButton) {
        interface?.signUpView(self, signUpButtonTapped: button)
    }
    
    //MARK: - StackView AddSubview
    
    private func addLabelsToStackView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descLabel)
    }
    
    private func addTextFieldsToStackView() {
        textFieldButtonStackView.addArrangedSubview(usernameTextField)
        textFieldButtonStackView.addArrangedSubview(emailTextField)
        textFieldButtonStackView.addArrangedSubview(passwordTextField)
        textFieldButtonStackView.addArrangedSubview(confirmPasswordTextField)
        textFieldButtonStackView.addArrangedSubview(signUpButton)
    }
    
    private func addSignInElementsStackView() {
        signInStackView.addArrangedSubview(signInLabel)
        signInStackView.addArrangedSubview(signInButton)
    }
    
    
    //MARK: - UI Elements Constraints
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(usernameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(signUpButton)
        addSubview(labelStackView)
        addSubview(textFieldButtonStackView)
        addSubview(signInLabel)
        addSubview(signInButton)
        addSubview(signInStackView)
    }
    
    private func setupConstraints() {
        labelStackViewConstraints()
        textFieldStackViewConstraints()
        signInStackViewConstraints()
    }
    
    private func labelStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.3)
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
    }
    
    private func textFieldStackViewConstraints() {
        textFieldButtonStackView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.4)
            make.top.equalTo(labelStackView.snp.bottom).offset(40)
            make.leading.equalTo(labelStackView.snp.leading)
            make.trailing.equalTo(labelStackView.snp.trailing)
        }
    }
    
    private func signInStackViewConstraints() {
        signInStackView.snp.makeConstraints { make in
            make.top.equalTo(textFieldButtonStackView.snp.bottom).offset(35)
            make.centerX.equalTo(textFieldButtonStackView.snp.centerX)
        }
    }
    
    
}




