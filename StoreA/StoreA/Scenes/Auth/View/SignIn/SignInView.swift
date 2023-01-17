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
    
    private var titleLabel = CustomLabel(text: "SignIn", numberOfLines: 0, font: .boldSystemFont(ofSize: 45), textColor: .blue, textAlignment: .left)
    private var descLabel = CustomLabel(text: "Welcome back", numberOfLines: 0, font: .systemFont(ofSize: 22), textColor: .systemGray, textAlignment: .left)
    private var labelStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 10, isHidden: false)
    var emailTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "envelope")!)
    var passwordTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "lock")!)
    private var signInButton = OnboardingButton(title: "Sign In", titleColor: .white, font: .boldSystemFont(ofSize: 19), backgroundColor: .blue, cornerRadius: 16)
    private var textFieldStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 25, isHidden: false)
    private var signUpLabel = CustomLabel(text: "Don't have an account?", numberOfLines: 1, font: .systemFont(ofSize: 18), textColor: .systemGray, textAlignment: .center)
    private var signUpButton = OnboardingButton(title: "Sign Up", titleColor: .systemOrange, font: .systemFont(ofSize: 15), backgroundColor: .systemGray6, cornerRadius: 16)
    private var signUpStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 5, isHidden: false)
    
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
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descLabel)
    }
    
    private func addTextFieldsToStackView() {
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        textFieldStackView.addArrangedSubview(signInButton)
    }
    
    private func addSignUpElementsToStackView() {
        signUpStackView.addArrangedSubview(signUpLabel)
        signUpStackView.addArrangedSubview(signUpButton)
    }
    
    //MARK: - UI Elements Constraints
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
        addSubview(labelStackView)
        addSubview(textFieldStackView)
        addSubview(signUpLabel)
        addSubview(signUpButton)
        addSubview(signUpStackView)
    }
    
    private func setupConstraints() {
        labelStackViewConstraints()
        textFieldStackViewConstraints()
        signUpStackViewConstratints()
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
        textFieldStackView.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.28)
            make.top.equalTo(labelStackView.snp.bottom).offset(40)
            make.leading.equalTo(labelStackView.snp.leading)
            make.trailing.equalTo(labelStackView.snp.trailing)
        }
    }
    
    private func signUpStackViewConstratints() {
        signUpStackView.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(35)
            make.centerX.equalTo(textFieldStackView.snp.centerX)
        }
    }
    
    
    
}

