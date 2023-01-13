//
//  CartView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 10.01.2023.
//

import UIKit

final class CartView: UIView {
    
    deinit {
        print("deinit cartview")
    }
    
    //MARK: - Creating UI Elements
    
    let cartCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    private let checkoutView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let priceTitle: UILabel = {
        let label = UILabel()
        label.text = "Total price"
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .black
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "checkmark.shield.fill"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        return button
    }()
    
    //MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddPriceLabelsToStackView
    
    private func addPriceLabelsToStackView() {
        priceStackView.addArrangedSubview(priceTitle)
        priceStackView.addArrangedSubview(priceLabel)
    }
    
    
    //MARK: - AddCheckoutViewElementsToCheckoutView
    
    private func addCheckoutElementsToCheckoutView() {
        checkoutView.addSubview(priceStackView)
        checkoutView.addSubview(checkoutButton)
    }
    
    
}


extension CartView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubview(cartCollection)
        addSubview(checkoutView)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        cartCollectionConstraints()
        addPriceLabelsToStackView()
        addCheckoutElementsToCheckoutView()
        priceStackViewConstraints()
        checkoutButtonConstraints()
        checkoutViewConstraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func cartCollectionConstraints() {
        cartCollection.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.width.height.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func checkoutViewConstraints() {
        checkoutView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(checkoutButton.snp.height).multipliedBy(1.5)
        }
    }
    
    private func priceStackViewConstraints() {
        priceStackView.snp.makeConstraints { make in
            make.leading.equalTo(checkoutView.snp.leading).offset(10)
            make.trailing.equalTo(checkoutButton.snp.leading).offset(20)
            make.centerY.equalTo(checkoutView.snp.centerY)
            make.height.equalTo(50)
        }
    }
    
    private func checkoutButtonConstraints() {
        checkoutButton.snp.makeConstraints { make in
            make.trailing.equalTo(checkoutView.snp.trailing).offset(-10)
            make.centerY.equalTo(checkoutView.snp.centerY)
        }
    }
    
    
    
    
    
}
