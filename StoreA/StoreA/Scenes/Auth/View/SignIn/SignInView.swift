//
//  SignInView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import UIKit

//MARK: - SignInViewInterface Protocol

protocol SignInViewInterface: AnyObject {
    func signInView(_ view: SignInView, signInButtonTapped button: UIButton)
    func signInView(_ view: SignInView, signUpButtonTapped button: UIButton)
}

final class SignInView: UIView {
    deinit {
        print("deinit signin view")
    }
    
    weak var interface: SignInViewInterface?
    
    //MARK: - Creating UI Elements
    
    private var titleLabel = CustomLabel(text: "SignIn", numberOfLines: 0, font: .boldSystemFont(ofSize: 45), textColor: .systemOrange, textAlignment: .left)
    private var descLabel = CustomLabel(text: "Welcome 👋", numberOfLines: 0, font: .systemFont(ofSize: 22), textColor: .systemGray, textAlignment: .left)
    private var labelStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 10, isHidden: false)
    var emailTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "envelope")!)
    var passwordTextField = CustomTextField(isSecureTextEntry: true, attributedPlaceholder: NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "lock")!)
    private var signInButton = CustomButton(title: "Sign In", titleColor: .white, font: .boldSystemFont(ofSize: 19), backgroundColor: .black, cornerRadius: 16)
    private var textFieldStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 25, isHidden: false)
    private var signUpLabel = CustomLabel(text: "Don't have an account?", numberOfLines: 1, font: .systemFont(ofSize: 18), textColor: .systemGray, textAlignment: .center)
    private var signUpButton = CustomButton(title: "Sign Up", titleColor: .systemOrange, font: .systemFont(ofSize: 15), backgroundColor: .systemGray6, cornerRadius: 16)
    private var signUpStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 10, isHidden: false)
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubviews()
        addLabelsToStackView()
        addTextFieldsToStackView()
        addSignUpElementsToStackView()
        setupConstraints()
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
        interface?.signInView(self, signInButtonTapped: button)
    }
    @objc private func signUpButtonTapped(_ button: UIButton) {
        interface?.signInView(self, signUpButtonTapped: button)
    }
    
    
    
    //MARK: - StackView AddSubview
    
    private func addLabelsToStackView() {
        labelStackView.addArrangedSubviews(titleLabel, descLabel)
        
    }
    
    private func addTextFieldsToStackView() {
        textFieldStackView.addArrangedSubviews(emailTextField, passwordTextField)
    }
    
    private func addSignUpElementsToStackView() {
        signUpStackView.addArrangedSubviews(signUpLabel, signUpButton)
    }
    
    //MARK: - UI Elements Constraints
    
    private func addSubviews() {
        addSubviews(labelStackView, textFieldStackView, signInButton, signUpStackView)
    }
    
    private func setupConstraints() {
        labelStackViewConstraints()
        textFieldStackViewConstraints()
        emailTextFieldConstraints()
        signInButtonConstraints()
        signUpStackViewConstraints()
    }
    
    private func labelStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.3)
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
    }
    
    private func emailTextFieldConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.06)
        }
    }
    
    private func textFieldStackViewConstraints() {
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(40)
            make.leading.equalTo(labelStackView.snp.leading)
            make.trailing.equalTo(labelStackView.snp.trailing)
        }
    }
    
    private func signInButtonConstraints() {
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(50)
            make.leading.trailing.equalTo(textFieldStackView)
            make.height.equalTo(56)
        }
    }
    
    
    private func signUpStackViewConstraints() {
        signUpStackView.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(35)
            make.centerX.equalTo(textFieldStackView.snp.centerX)
        }
    }
    
    
    
}

