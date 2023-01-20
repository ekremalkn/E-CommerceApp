//
//  HomeView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 2.01.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func homeView(_ view: HomeView, cartButtonTapped button: UIButton)
    func homeView(_ view: HomeView, wishListButtonTapped button: UIButton)
    func homeView(_ view: HomeView, seeAllButtonTapped button: UIButton )
}

final class HomeView: UIView {
 
    //MARK: - Creating UI Elements
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private var contentView = CustomView()
    var profilePhotoImage = CustomImageView(image: UIImage(systemName: "person.circle")!, tintColor: .black, backgroundColor: .systemGray6, contentMode: .scaleToFill, maskedToBounds: true, cornerRadius: 25, isUserInteractionEnabled: false)
    var hiLabel = CustomLabel(text: "Good morning👋", numberOfLines: 0, font: .systemFont(ofSize: 15), textColor: .systemGray, textAlignment: .left)
    var usernameLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 20), textColor: .black, textAlignment: .left)
    private var labelStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 10, isHidden: false)
    private var wishListButton = CustomButton(backgroundColor: .white, cornerRadius: 15,image: UIImage(systemName: "heart"),tintColor: .black)
    private var cartButton = CustomButton(backgroundColor: .white, cornerRadius: 15, image: UIImage(systemName: "cart"), tintColor: .black)
    private var buttonStackView = CustomStackView(axis: .horizontal, distiribution: .fillEqually, isHidden: false)
    var searcBar = CustomSearchBar(showsBookmarkButton: false, placeHolder: "Search Products")
    private var specialProductsLabel = CustomLabel(text: "Special Products", numberOfLines: 0, font: .boldSystemFont(ofSize: 18), textColor: .black, textAlignment: .left)
    private var seeAllButton = CustomButton(title: "See All", titleColor: .black, font: .boldSystemFont(ofSize: 15), backgroundColor: .systemGray6, cornerRadius: 16)
    private var specialLblSeeBtnView = CustomView()
    var specialCollection = CustomCollection(backgroundColor: .white, cornerRadius: 30, showsScrollIndicator: false, paging: true,layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal)
    var pageControl = CustomPageControl()
    var categoryCollection = CustomCollection(backgroundColor: .systemGray6, showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal, estimatedItemSize: UICollectionViewFlowLayout.automaticSize, minimumInteritemSpacing: 0, minimumLineSpacing: 5)
    var productCollection = CustomCollection(backgroundColor: .systemGray6, showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    
    //MARK: - PageControl CurrentPage
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    //MARK: - Properties
    
    weak var interface: HomeViewInterface?
    
    
    //MARK: - Init Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemGray6
        searcBar.barTintColor = .systemGray6
        addSubview()
        setupConstraints()
        configureSearchBar()
        addTarget()
    }
    
    
    //MARK: - AddAction
    
    private func addTarget() {
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        wishListButton.addTarget(self, action: #selector(wishListButtonTapped), for: .touchUpInside)
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Buttons actions
    
    @objc private func cartButtonTapped(_ button: UIButton) {
        interface?.homeView(self, cartButtonTapped: button)
    }
    
    @objc private func wishListButtonTapped(_ button: UIButton) {
        interface?.homeView(self, wishListButtonTapped: button)
    }
    
    @objc private func seeAllButtonTapped(_ button: UIButton) {
        interface?.homeView(self, seeAllButtonTapped: button)
    }
    
    
    
    //MARK: - Configure SearchBar
    
    private func configureSearchBar() {
        searcBar.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)
    }
    
}


//MARK: - UI Elements AddSubiew / Constraints

extension HomeView {
    
    //MARK: - AddSubView
    
    private func addSubview() {
        addSubviews(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(profilePhotoImage, labelStackView, buttonStackView, searcBar, specialLblSeeBtnView, specialCollection, pageControl, categoryCollection, productCollection)
        addTopLabelsToStackView()
        addTopButtonsToStackView()
        addSpecialLblSeeBtnToView()
    }
    
    private func addTopLabelsToStackView() {
        labelStackView.addArrangedSubviews(hiLabel, usernameLabel)
    }
    
    private func addTopButtonsToStackView() {
        buttonStackView.addArrangedSubviews(wishListButton, cartButton)
    }
    
    private func addSpecialLblSeeBtnToView() {
        specialLblSeeBtnView.addSubviews(specialProductsLabel, seeAllButton)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        scrollViewConstraints()
        contentViewConstraints()
        profilePhotoImageConstraints()
        topLabelsStackViewConstraints()
        topButtonsStackViewConstraints()
        searchBarConstraints()
        specialLblSeeBtnViewConstraints()
        specialLblConstraints()
        seeAllButtonConstraints()
        specialCollectionConstraints()
        pageControlConstraints()
        categoryCollectionConstraints()
        productsCollectionConstraint()
    }
    
    private func scrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func contentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(2500)
        }
    }
    
    private func profilePhotoImageConstraints() {
        profilePhotoImage.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.equalTo(scrollView).offset(15)
            make.leading.equalTo(scrollView).offset(15)
        }
    }
    
    private func topLabelsStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(15)
            make.centerY.equalTo(profilePhotoImage.snp.centerY)
            make.leading.equalTo(profilePhotoImage.snp.trailing).offset(5)
        }
    }
    
    private func topButtonsStackViewConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(labelStackView.snp.height)
            make.centerY.equalTo(profilePhotoImage.snp.centerY)
            make.leading.equalTo(labelStackView.snp.trailing)
            make.trailing.equalTo(scrollView).offset(-15)
        }
    }
    
    private func searchBarConstraints() {
        searcBar.snp.makeConstraints { make in
            make.top.equalTo(profilePhotoImage.snp.bottom).offset(15)
            make.leading.equalTo(profilePhotoImage.snp.leading)
            make.trailing.equalTo(buttonStackView.snp.trailing)
            
        }
    }
    
    private func specialLblSeeBtnViewConstraints() {
        specialLblSeeBtnView.snp.makeConstraints { make in
            make.height.equalTo(specialProductsLabel.snp.height)
            make.top.equalTo(searcBar.snp.bottom).offset(10)
            make.leading.equalTo(searcBar.snp.leading)
            make.trailing.equalTo(searcBar.snp.trailing)
        }
    }
    
    private func specialLblConstraints() {
        specialProductsLabel.snp.makeConstraints { make in
            make.leading.equalTo(specialLblSeeBtnView.snp.leading)
            make.centerY.equalTo(specialLblSeeBtnView.snp.centerY)
            make.trailing.equalTo(seeAllButton.snp.leading)
        }
    }
    
    private func seeAllButtonConstraints() {
        seeAllButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.centerY.equalTo(specialLblSeeBtnView.snp.centerY)
            make.trailing.equalTo(specialLblSeeBtnView.snp.trailing)
        }
    }
    
    private func specialCollectionConstraints() {
        specialCollection.snp.makeConstraints { make in
            make.top.equalTo(specialLblSeeBtnView.snp.bottom).offset(10)
            make.bottom.equalTo(scrollView.snp.centerY)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
        }
    }
    
    private func pageControlConstraints() {
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(specialCollection.snp.bottom).offset(5)
            make.centerX.equalTo(specialCollection.snp.centerX)
            make.leading.equalTo(specialCollection.snp.leading)
            make.trailing.equalTo(specialCollection.snp.trailing)
        }
        
    }
    
    private func categoryCollectionConstraints() {
        categoryCollection.snp.makeConstraints { make in
            make.height.equalTo(specialCollection.snp.width).multipliedBy(0.1)
            make.width.equalTo(specialCollection.snp.width)
            make.top.equalTo(pageControl.snp.bottom)
            make.leading.equalTo(searcBar.snp.leading)
            make.trailing.equalTo(searcBar.snp.trailing)
        }
    }
    
    private func productsCollectionConstraint() {
        productCollection.snp.makeConstraints { make in
            make.top.equalTo(categoryCollection.snp.bottom).offset(20)
            make.trailing.equalTo(searcBar.snp.trailing)
            make.leading.equalTo(searcBar.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
}


