//
//  ProfileView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit

protocol ProfileViewInterface: AnyObject {
    func profileView(_ view: ProfileView, signOutButtonTapped button: UIButton)
}

class ProfileView: UIView {

    //MARK: - Creating UI Elements
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 15
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let userInfosView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
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
        profileImageView.image = UIImage(named: "ekremalkan")
        userNameLabel.text = "Username: \(username)"
        emailLabel.text = "Email: \(email)"
    }
    
    
    //MARK: - AddTarget
    
    private func addTarget() {
        signOutButton.addTarget(self, action: #selector(addTargetButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - AddAction
    
    @objc private func addTargetButtonTapped(_ button: UIButton) {
        interface?.profileView(self, signOutButtonTapped: button)
    }


    //MARK: - Username/Email labels AddToStackView
    
    
    private func userInfosAddToStackView() {
        userInfosView.addSubview(profileImageView)
        userInfosView.addSubview(userNameLabel)
        userInfosView.addSubview(emailLabel)
        userInfosView.addSubview(signOutButton)
    }

    
}

extension ProfileView {
    
    //MARK: - AddSubview

    private func addSubview() {
        addSubview(userInfosView)
        userInfosAddToStackView()
    }
    
    //MARK: - Setup Constraints

    private func setupConstraints() {
        userInfosViewConstraints()
        profileImageViewConstraints()
        usernameLabelConstraints()
        emailLabelConstraints()
        signOutButtonConstraints()
        
    }
    
    //MARK: - UI Elements Constraints
    
    private func profileImageViewConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(userInfosView.snp.top).offset(20)
            make.height.width.equalTo(userInfosView.snp.width).multipliedBy(0.5)
            make.centerX.equalTo(userInfosView.snp.centerX)
        }
    }
    
    private func usernameLabelConstraints() {
        userNameLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.centerX.equalTo(profileImageView.snp.centerX)
        }
    }
    
    private func emailLabelConstraints() {
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.top.equalTo(userNameLabel.snp.bottom).offset(20)
            make.centerX.equalTo(userNameLabel.snp.centerX)
        }
    }
    
    private func signOutButtonConstraints() {
        signOutButton.snp.makeConstraints { make in
            make.width.equalTo(userInfosView.snp.width).multipliedBy(0.5)
            make.height.equalTo(userInfosView.snp.width).multipliedBy(0.1)
            make.top.equalTo(emailLabel.snp.bottom).offset(80)
            make.centerX.equalTo(profileImageView.snp.centerX)
        }
    }
    
    private func userInfosViewConstraints() {
        userInfosView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(safeAreaLayoutGuide).offset(50)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-50)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-50)
        }
    }

        
}


