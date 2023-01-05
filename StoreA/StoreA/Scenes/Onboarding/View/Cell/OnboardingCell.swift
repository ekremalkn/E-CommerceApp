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
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var slideLblStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 45
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - override method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraint()
        addSlideLblsToStackView()
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
    
    //MARK: - StackView AddSubviews
    
    private func addSlideLblsToStackView() {
        slideLblStackView.addArrangedSubview(slideTitleLbl)
        slideLblStackView.addArrangedSubview(slideDescLbl)
    }
    
    //MARK: - UI Elements Constraints
    
    private func addSubview() {
        addSubview(onboardingImage)
        addSubview(slideTitleLbl)
        addSubview(slideDescLbl)
        addSubview(slideLblStackView)
    }
    
    private func setupConstraint() {
        onboardinImageConstraint()
        slideLblStackViewConstraints()
    }
    
    private func onboardinImageConstraint() {
        onboardingImage.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func slideLblStackViewConstraints() {
        slideLblStackView.snp.makeConstraints { make in
            make.top.equalTo(onboardingImage.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
            make.bottom.equalTo(slideDescLbl.snp.bottom)
        }
    }
}
