//
//  HomeView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 2.01.2023.
//

import UIKit

final class HomeView: UIView {
    
    //MARK: - Properties
    private let homeViewModel = ProductsViewModel()
    
    //MARK: - Creating UI Elements
    
    private var profilePhotoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.tintColor = .black
        imageView.image = UIImage(named: "ekremalkan")
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var hiLabel: UILabel = {
        let label = UILabel()
        label.text = "Good morning👋"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Ekrem Alkan"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
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
    
    private var notificationButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var cartButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
     var searcBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.placeholder = "Search Products"
        searchBar.showsBookmarkButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var specialProductsLabel: UILabel = {
        let label = UILabel()
        label.text = "Specail Products"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var specialLblSeeBtnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
     var specialCollection: UICollectionView = {
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
    
     var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .systemGray
        return pageControl
    }()
    
     var categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
     var productCollection: UICollectionView = {
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
    
    //MARK: - Init Method
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        searcBar.barTintColor = .systemGray6
        addSubview()
        setupConstraints()
        
        configureSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
       
    
 
    //MARK: - TopLabelsAddToStackView
    
    private func addTopLabelsToStackView() {
        labelStackView.addArrangedSubview(hiLabel)
        labelStackView.addArrangedSubview(userEmailLabel)
    }
    
    //MARK: - TopButtonsAddToStackView
    
    private func addTopButtonsToStackView() {
        buttonStackView.addArrangedSubview(notificationButton)
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
            make.height.equalTo(specialCollection.snp.height).multipliedBy(0.2)
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
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
