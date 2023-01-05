//
//  SignInView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import UIKit

//MARK: - SignInViewInterface Protocol

protocol SignInViewInterface: AnyObject {
    func signInView(_ view: SignInView, didTapSignInButton button: UIButton)
    func signInView(_ view: SignInView, didTapSignUpButton button: UIButton)
}

final class SignInView: UIView {
    
    weak var interface: SignInViewInterface?
    
    //MARK: - Creating UI Elements
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SignIn"
        label.textColor = .blue
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back"
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.leftViewMode = .always
        let imageView = UIImageView()
        let image = UIImage(systemName: "envelope")
        imageView.image = image
        imageView.tintColor = .systemGray
        textField.leftView = imageView
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.leftViewMode = .always
        let imageView = UIImageView()
        let image = UIImage(systemName: "lock")
        imageView.image = image
        imageView.tintColor = .systemGray
        textField.leftView = imageView
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        interface?.signInView(self, didTapSignInButton: button)
    }
    @objc private func signUpButtonTapped(_ button: UIButton) {
        interface?.signInView(self, didTapSignUpButton: button)
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

