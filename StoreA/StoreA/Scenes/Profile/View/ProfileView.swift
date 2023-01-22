//
//  ProfileView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit

protocol ProfileViewInterface: AnyObject {
    func profileView(_ view: ProfileView, signOutButtonTapped button: UIButton)
    func profileView(_ view: ProfileView, addProfileButtonTapped button: UIButton)
    func profileView(_ view: ProfileView, resetPasswordButtonTapped button: UIButton)
}

final class ProfileView: UIView {
    
    //MARK: - Creating UI Elements
    
    private var profileTitleImage = CustomImageView(image: UIImage(systemName: "person.fill")!, tintColor: .black, backgroundColor: .white, contentMode: .scaleToFill, cornerRadius: 0, isUserInteractionEnabled: false)
    private var profileTitleLabel = CustomLabel(text: "Profile", numberOfLines: 0, font: .boldSystemFont(ofSize: 17), textColor: .black, textAlignment: .left)
    private var profileTitleView = CustomView(backgroundColor: .white, cornerRadius: 0)
    private var moreInfoButton = CustomButton(image: UIImage(systemName: "ellipsis.circle"), tintColor: .black)
    var profileImageView = CustomImageView(image: UIImage(systemName: "person")!, tintColor: .black, backgroundColor: .white, contentMode: .scaleToFill, maskedToBounds: true, cornerRadius: 75, isUserInteractionEnabled: false)
    var profileImageActivityIndicator = UIActivityIndicatorView(style: .large)
    private var userNameLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 20), textColor: .black, textAlignment: .center)
    private var emailLabel = CustomLabel(text: "", numberOfLines: 0, font: .systemFont(ofSize: 15), textColor: .black, textAlignment: .center)
    private var userInfoStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 10)
    private var seperatorView = CustomView(backgroundColor: .systemGray5)
    private var addProfilPhotoButton = CustomButton(title: "Upoad Profile Photo", titleColor: .black, backgroundColor: .systemGray6, cornerRadius: 28)
    private var seperatorView2 = CustomView(backgroundColor: .systemGray5)
    private var resetPasswordButton = CustomButton(title: "Change password", titleColor: .white, backgroundColor: .black, cornerRadius: 28)
    private var signOutButton = CustomButton(title: "Sign Out", titleColor: .white, backgroundColor: .red, cornerRadius: 15, image: UIImage(systemName: "multiply"), tintColor: .white, imageEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), titleEdgeInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    var activiyIndicator = UIActivityIndicatorView()
    //MARK: - Propertis
    
    weak var interface: ProfileViewInterface?
    
    //MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview()
        setupConstraints()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(email: String, username: String) {
        profileImageView.image = UIImage(systemName: "person")
        userNameLabel.text = "\(username)"
        emailLabel.text = "\(email)"
    }
    
    
    //MARK: - AddTarget
    
    private func addTarget() {
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        addProfilPhotoButton.addTarget(self, action: #selector(addProfileButtonTapped), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - AddAction
    
    @objc private func addProfileButtonTapped(_ button: UIButton) {
        activiyIndicator.startAnimating()
        interface?.profileView(self, addProfileButtonTapped: button)
    }
    
    @objc private func resetPasswordButtonTapped(_ button: UIButton) {
        interface?.profileView(self, resetPasswordButtonTapped: button)
    }
    
    @objc private func signOutButtonTapped(_ button: UIButton) {
        interface?.profileView(self, signOutButtonTapped: button)
    }
    
}

//MARK: - UI Elements AddSubiew / Constraints

extension ProfileView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(activiyIndicator, profileTitleView, moreInfoButton, profileImageView, userInfoStackView, seperatorView, addProfilPhotoButton, seperatorView2, resetPasswordButton, signOutButton)
        activityIndicatorToProfileImage()
        profileTitleAddToView()
        addUserInfosToStackView()
    }
    
    private func activityIndicatorToProfileImage() {
        profileImageView.addSubview(profileImageActivityIndicator)
    }
    
    private func profileTitleAddToView() {
        profileTitleView.addSubviews(profileTitleImage, profileTitleLabel)
    }
    
    private func addUserInfosToStackView() {
        userInfoStackView.addArrangedSubviews(userNameLabel, emailLabel)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        activityIndicatorConstraints()
        profileTitleViewConstraints()
        profileTitleImageConstraints()
        profileTitleConstraints()
        moreInfoButtonConstraints()
        profileImageViewConstraints()
        profileImageActivityIndicatorConstraints()
        userInfosStackViewConstraints()
        seperatorViewConstraints()
        addProfilePhotoButtonConstraints()
        seperatorView2Constraints()
        resetPasswordButtonConstraints()
        signOutButtonConsraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func activityIndicatorConstraints() {
        activiyIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func profileTitleViewConstraints() {
        profileTitleView.snp.makeConstraints { make in
            make.height.equalTo(profileTitleLabel.snp.height)
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
        }
    }
    
    private func profileTitleImageConstraints() {
        profileTitleImage.snp.makeConstraints { make in
            make.height.width.equalTo(profileTitleLabel.snp.height)
            make.leading.equalTo(profileTitleView.snp.leading)
            make.centerY.equalTo(profileTitleView.snp.centerY)
        }
    }
    
    private func profileTitleConstraints() {
        profileTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileTitleImage.snp.trailing).offset(10)
            make.centerY.equalTo(profileTitleView.snp.centerY)
            make.trailing.equalTo(profileTitleView.snp.trailing)
        }
        
    }
    
    private func moreInfoButtonConstraints() {
        moreInfoButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
            make.centerY.equalTo(profileTitleView)
        }
    }
    
    private func profileImageViewConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.top.equalTo(profileTitleView.snp.bottom).offset(25)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    private func profileImageActivityIndicatorConstraints() {
        profileImageActivityIndicator.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(profileImageView)
        }
    }
    
    private func userInfosStackViewConstraints() {
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(15)
            make.centerX.equalTo(profileImageView.snp.centerX)
            
        }
    }
    
    private func seperatorViewConstraints() {
        seperatorView.snp.makeConstraints { make in
            make.height.equalTo(0.75)
            make.top.equalTo(userInfoStackView.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
        }
    }
    
    private func addProfilePhotoButtonConstraints() {
        addProfilPhotoButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(seperatorView.snp.bottom).offset(30)
            make.centerX.equalTo(seperatorView.snp.centerX)
            make.width.equalTo(seperatorView).multipliedBy(0.8)
        }
    }
    
    private func seperatorView2Constraints() {
        seperatorView2.snp.makeConstraints { make in
            make.height.equalTo(0.75)
            make.top.equalTo(addProfilPhotoButton.snp.bottom).offset(30)
            make.leading.trailing.equalTo(seperatorView)
        }
    }
    
    private func resetPasswordButtonConstraints() {
        resetPasswordButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(seperatorView2.snp.bottom).offset(30)
            make.width.equalTo(seperatorView).multipliedBy(0.7)
            make.centerX.equalTo(addProfilPhotoButton.snp.centerX)
            make.bottom.equalTo(signOutButton.snp.top).offset(-30)
        }
    }
    
    private func signOutButtonConsraints() {
        signOutButton.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.1)
            make.width.equalTo(resetPasswordButton.snp.width).multipliedBy(0.5)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
    }
    
    
    
    
    
    
    
}


