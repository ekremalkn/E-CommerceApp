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
    deinit {
        print("deinit home view")
    }
    
    //MARK: - Creating UI Elements
    
    lazy var profilePhotoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = nil
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "person.circle")
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var hiLabel = CustomLabel(text: "Good morning👋", numberOfLines: 0, font: .systemFont(ofSize: 15), textColor: .systemGray, textAlignment: .left)
    lazy var usernameLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 20), textColor: .black, textAlignment: .left)
    lazy var labelStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 10, isHidden: false)
    lazy var wishListButton = HomeButton(image: UIImage(systemName: "heart")!)
    lazy var cartButton = HomeButton(image: UIImage(systemName: "cart")!)
    lazy var buttonStackView = CustomStackView(axis: .horizontal, distiribution: .fillEqually, spacing: 10, isHidden: false)
    lazy var searcBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.placeholder = "Search Products"
        searchBar.showsBookmarkButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    lazy var specialProductsLabel = CustomLabel(text: "Special Products", numberOfLines: 0, font: .boldSystemFont(ofSize: 18), textColor: .blue, textAlignment: .left)
    lazy var seeAllButton = OnboardingButton(title: "See All", titleColor: .black, font: .boldSystemFont(ofSize: 15), backgroundColor: .systemGray6, cornerRadius: 16)
    lazy var specialLblSeeBtnStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 0, isHidden: false)
    lazy var specialCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.layer.cornerRadius = 30
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var pageControl = CustomPageControl()
    lazy var categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var productCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.showsVerticalScrollIndicator = false
        collection.isPagingEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
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
        backgroundColor = .systemGray6
        searcBar.barTintColor = .systemGray6
        addSubview()
        setupConstraints()
        configureSearchBar()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    
    //MARK: - TopLabelsAddToStackView
    
    private func addTopLabelsToStackView() {
        labelStackView.addArrangedSubview(hiLabel)
        labelStackView.addArrangedSubview(usernameLabel)
    }
    
    //MARK: - TopButtonsAddToStackView
    
    private func addTopButtonsToStackView() {
        buttonStackView.addArrangedSubview(wishListButton)
        buttonStackView.addArrangedSubview(cartButton)
    }
    
    //MARK: - SpecialLabel / SeeAll Button AddToStackView
    
    private func addSpecialLblSeeBtnToStackView() {
        specialLblSeeBtnStackView.addArrangedSubview(specialProductsLabel)
        specialLblSeeBtnStackView.addArrangedSubview(seeAllButton)
    }
    
    
    //MARK: - Configure SearchBar
    
    private func configureSearchBar() {
        searcBar.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)
    }
    
}



extension HomeView {
    
    //MARK: - AddSubView
    
    private func addSubview() {
        addSubview(profilePhotoImage)
        addTopLabelsToStackView()
        addSubview(labelStackView)
        addTopButtonsToStackView()
        addSubview(buttonStackView)
        addSubview(searcBar)
        addSpecialLblSeeBtnToStackView()
        addSubview(specialLblSeeBtnStackView)
        addSubview(specialCollection)
        addSubview(pageControl)
        addSubview(categoryCollection)
        addSubview(productCollection)
        
        
        
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        profilePhotoImageConstraints()
        topLabelsStackViewConstraints()
        topButtonsStackViewConstraints()
        searchBarConstraints()
        specialLblSeeBtnStackViewConstraints()
        specialCollectionConstraints()
        pageControlConstraints()
        categoryCollectionConstraints()
        productsCollectionConstraint()
    }
    
    
    //MARK: - UI Elements Constranints
    
    private func profilePhotoImageConstraints() {
        profilePhotoImage.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
        }
    }
    
    private func topLabelsStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.centerY.equalTo(profilePhotoImage.snp.centerY)
            make.leading.equalTo(profilePhotoImage.snp.trailing).offset(5)
        }
    }
    
    private func topButtonsStackViewConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.centerY.equalTo(profilePhotoImage.snp.centerY)
            make.leading.equalTo(labelStackView.snp.trailing)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
        }
    }
    
    private func searchBarConstraints() {
        searcBar.snp.makeConstraints { make in
            make.top.equalTo(profilePhotoImage.snp.bottom).offset(15)
            make.leading.equalTo(profilePhotoImage.snp.leading)
            make.trailing.equalTo(buttonStackView.snp.trailing)
            
        }
    }
    
    private func specialLblSeeBtnStackViewConstraints() {
        specialLblSeeBtnStackView.snp.makeConstraints { make in
            make.top.equalTo(searcBar.snp.bottom).offset(10)
            make.leading.equalTo(searcBar.snp.leading)
            make.trailing.equalTo(searcBar.snp.trailing)
        }
    }
    
    private func specialCollectionConstraints() {
        specialCollection.snp.makeConstraints { make in
            make.top.equalTo(specialLblSeeBtnStackView.snp.bottom).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY)
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
            make.top.equalTo(categoryCollection.snp.bottom).offset(30)
            make.trailing.equalTo(searcBar.snp.trailing)
            make.leading.equalTo(searcBar.snp.leading)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
