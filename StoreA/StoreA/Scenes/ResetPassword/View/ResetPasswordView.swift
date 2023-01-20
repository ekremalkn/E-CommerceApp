//
//  ResetPasswordView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 20.01.2023.
//

import UIKit

protocol ResetPasswordViewInterface: AnyObject {
    func resetPasswordView(_ view: ResetPasswordView, resetPasswordButtonTapped button: UIButton)
}

final class ResetPasswordView: UIView {
    
    weak var interface: ResetPasswordViewInterface?
    
    //MARK: - Creating UI Elements
    
    private var titleLabel = CustomLabel(text: "Send a password reset email.", numberOfLines: 0, font: .boldSystemFont(ofSize: 30), textColor: .black, textAlignment: .left)
    
    var emailTextField = CustomTextField(attributedPlaceholder: NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]), image: UIImage(systemName: "envelope")!)
    private var resetPasswordButton = CustomButton(title: "Reset password.", titleColor: .white, backgroundColor: .black, cornerRadius: 28)
    
    
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubview()
        setupConstraints()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddAction
    
    private func addTarget() {
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
    }
    
    @objc private func resetPasswordButtonTapped(_ button: UIButton) {
        interface?.resetPasswordView(self, resetPasswordButtonTapped: button)
    }
    
    
}

//MARK: - UI Elements AddSubiew / Constraints

extension ResetPasswordView {
    
    //MARK: - AddSubviews
    
    private func addSubview() {
        addSubviews(titleLabel, emailTextField, resetPasswordButton)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        emailtTextFieldConstraints()
        resetPasswordButtonConstraints()
        titleLabelConstraints()
    }
    
    
    private func titleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY).offset(-200)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
    }
    
    private func emailtTextFieldConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.06)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY).offset(-100)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
    }
    
    private func resetPasswordButtonConstraints() {
        resetPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(emailTextField.snp.bottom).offset(35)
            make.centerX.equalTo(emailTextField.snp.centerX)
            make.width.equalTo(emailTextField).multipliedBy(0.5)
        }
    }
    
}
