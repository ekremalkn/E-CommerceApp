//
//  OnboardingCell.swift
//  StoreA
//
//  Created by Ekrem Alkan on 30.12.2022.
//

import UIKit
import SnapKit

class OnboardingCell: UICollectionViewCell {
    
    //MARK: - Cell's Identifier
    
    static let identifier = "OnboardingCell"
    
    //MARK: - Creating UI Elements
    
    private var onboardingImage: UIImageView  = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var slideTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "Search app for products"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var slideDescLbl: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - override method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(data: OnboardingSlide) {
        onboardingImage.image = data.image
        slideTitleLbl.text = data.title
        slideDescLbl.text = data.description
    }
    
    
    //MARK: - UI Elements Constraints
    
    private func addSubview() {
        addSubview(onboardingImage)
        addSubview(slideTitleLbl)
        addSubview(slideDescLbl)
    }
    
    private func setupConstraint() {
        onboardinImageConstraint()
        slideTitleLblConstraint()
        slideDescLblConstraint()
    }
    
    private func onboardinImageConstraint() {
        onboardingImage.snp.makeConstraints { make in
            make.height.width.equalTo(300)
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-250)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func slideTitleLblConstraint() {
        slideTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(onboardingImage.snp.bottom).offset(30)
            make.leading.equalTo(onboardingImage.snp.leading)
            make.trailing.equalTo(onboardingImage.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-150)
        }
    }
    
    private func slideDescLblConstraint() {
        slideDescLbl.snp.makeConstraints { make in
            make.top.equalTo(slideTitleLbl.snp.bottom).offset(10)
            make.leading.equalTo(slideTitleLbl.snp.leading)
            make.trailing.equalTo(slideTitleLbl.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-50)
        }
    }
}
