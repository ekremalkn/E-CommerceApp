//
//  SignUpController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 31.12.2022.
//

import UIKit
import SnapKit

final class SignUpController: UIViewController {
    
    //MARK: - Creating UI Elements

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SignUp"
        label.textColor = .blue
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back, get back to exploring our amazing products."
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
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
    
    private var passwordTextField: UITextField = {
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
    
    private var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
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
    
    private var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - ViewDidLoad Method

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addSubviews()
        setupConstraints()
        addLabelsToStackView()
        addTextFieldsToStackView()
      
    }
    
    //MARK: - StackView AddSubview

    private func addLabelsToStackView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descLabel)
    }
    
    private func addTextFieldsToStackView() {
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        textFieldStackView.addArrangedSubview(confirmPasswordTextField)
        textFieldStackView.addArrangedSubview(signUpButton)
    }
    
}

//MARK: - UI Elements Constraints()

extension SignUpController {
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(labelStackView)
        view.addSubview(textFieldStackView)
        view.addSubview(signUpButton)
    }
    
    private func setupConstraints() {
        labelStackViewConstraints()
        emailTextFieldConstraints()
        passwordTextFieldConstraints()
        confirmPasswordTextFieldConstraints()
        textFieldStackViewConstraints()
        signUpButtonConstraints()
    }

    private func labelStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
    }
    
    private func emailTextFieldConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
    
    private func passwordTextFieldConstraints() {
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
    
    private func confirmPasswordTextFieldConstraints() {
        confirmPasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
    
    private func textFieldStackViewConstraints() {
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(40)
            make.leading.equalTo(labelStackView.snp.leading)
            make.trailing.equalTo(labelStackView.snp.trailing)
        }
    }
    
    private func signUpButtonConstraints() {
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
    }
}
