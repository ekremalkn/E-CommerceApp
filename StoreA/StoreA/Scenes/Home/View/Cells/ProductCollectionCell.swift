//
//  ProductCollectionCell.swift
//  StoreA
//
//  Created by Ekrem Alkan on 3.01.2023.
//

import UIKit

protocol ProductCollectionCellProtocol {
    var productImage: String { get }
    var productTitle: String { get }
    var productRatingCount: String { get }
    var productSalesAmount: String { get }
    var productPrice: String { get }
    var productId: Int { get }
}

protocol ProductCollectionCellInterface: AnyObject {
    func productCollectionCell(_ view: ProductCollectionCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton)
}

class ProductCollectionCell: UICollectionViewCell {
    deinit {
        print("deinit productcell")
    }
    
    //MARK: - Cell's Identifier
    
    static let identifier = "ProductCollectionCell"
    
    //MARK: - Creating UI Elements
    
    private var productImageView = CustomImageView(image: UIImage(systemName: "exclamationmark.circle")!, tintColor: .black, backgroundColor: .white, contentMode: .scaleAspectFit, cornerRadius: 0, isUserInteractionEnabled: true)
    var addToWishListButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.backgroundColor = nil
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var titleLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 10), textColor: .black, textAlignment: .center)
    private var ratingCountImageView = CustomImageView(image: UIImage(systemName: "star.fill")!, tintColor: .black, backgroundColor: .white, contentMode: .scaleAspectFit, cornerRadius: 0, isUserInteractionEnabled: false)
    private var ratingCountLabel = CustomLabel(text: "", numberOfLines: 2, font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left)
    private var ratingCountStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 5, isHidden: false)
    private var salesAmountLabel = CustomLabel(text: "", numberOfLines: 1, font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .right)
    private var ratingSalesInfoStackView = CustomStackView(axis: .horizontal, distiribution: .fillEqually, spacing: 0, isHidden: false)
    private var priceLabel = CustomLabel(text: "", numberOfLines: 1, font: .boldSystemFont(ofSize: 12), textColor: .black, textAlignment: .left)
    private var productInfoStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 0, isHidden: false)
    
    //MARK: - Properties
    var productId: Int?
    weak var interface: ProductCollectionCellInterface?
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15
        addSubview()
        setupConstraints()
        addTarget()
        toggleAddButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureCell
    
    func configure(data: ProductCollectionCellProtocol) {
        productImageView.downloadSetImage(url: data.productImage)
        titleLabel.text = data.productTitle
        ratingCountLabel.text = data.productRatingCount
        salesAmountLabel.text = data.productSalesAmount
        priceLabel.text = data.productPrice
        productId = data.productId
    }
    
    //MARK: - AddAction
    
    private func addTarget() {
        addToWishListButton.addTarget(self, action: #selector(addToWishListButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Buttons actions
    
    @objc private func addToWishListButtonTapped(_ button: UIButton) {
        guard let productId = productId else { return }
        if addToWishListButton.isSelected == false {
            interface?.productCollectionCell(self, productId: productId, quantity: 1, wishButtonTapped: button)
        } else {
            interface?.productCollectionCell(self, productId: productId, quantity: 0, wishButtonTapped: button)
        }
        addToWishListButton.isSelected.toggle()
        
    }
    
    func toggleAddButton() {
        let image = UIImage(systemName: "heart")
        let imageFilled = UIImage(systemName: "heart.fill")
        addToWishListButton.setImage(image, for: .normal)
        addToWishListButton.setImage(imageFilled, for: .selected)
    }
    
    
    
    //MARK: - AddButtonToImageView
    
    private func addButtonToImageView() {
        productImageView.addSubview(addToWishListButton)
    }
    
    //MARK: - AddRatingElementsToStackView
    
    private func addRatingElementsToStackView() {
        ratingCountStackView.addArrangedSubview(ratingCountImageView)
        ratingCountStackView.addArrangedSubview(ratingCountLabel)
    }
    
    //MARK: - AddRatingSalesInfoToStackView
    
    private func addRatingSalesInfoToStackView() {
        ratingSalesInfoStackView.addArrangedSubview(ratingCountStackView)
        ratingSalesInfoStackView.addArrangedSubview(salesAmountLabel)
    }
    
    //MARK: - AddProductInfoToStackView
    
    private func addProductInfoToStackView() {
        productInfoStackView.addArrangedSubview(titleLabel)
        productInfoStackView.addArrangedSubview(ratingSalesInfoStackView)
        productInfoStackView.addArrangedSubview(priceLabel)
    }
    
    
    
    ///MARK: - AddSubview
    
    private func addSubview() {
        addSubview(productImageView)
        addButtonToImageView()
        addSubview(ratingCountStackView)
        addRatingElementsToStackView()
        addSubview(ratingSalesInfoStackView)
        addRatingSalesInfoToStackView()
        addSubview(productInfoStackView)
        addProductInfoToStackView()
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        imageViewConstraints()
        addToWishListButtonConstraints()
        ratingCountImageConstraints()
        ratingCountStackViewConstraints()
        productInfoStackViewConstraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func imageViewConstraints() {
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.width).offset(-10)
            make.top.equalTo(safeAreaLayoutGuide)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(productInfoStackView.snp.top).offset(-10)
            
        }
    }
    
    private func addToWishListButtonConstraints() {
        addToWishListButton.snp.makeConstraints { make in
            make.width.equalTo(productImageView.snp.width).multipliedBy(0.2)
            make.height.equalTo(productImageView.snp.width).multipliedBy(0.2)
            make.top.equalTo(productImageView).offset(7)
            make.trailing.equalTo(productImageView).offset(-7)
        }
    }
    
    private func ratingCountImageConstraints() {
        ratingCountImageView.snp.makeConstraints { make in
            make.width.height.equalTo(ratingCountStackView.snp.height)
        }
    }
    private func ratingCountStackViewConstraints() {
        ratingCountStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.leading.equalTo(productImageView.snp.leading)
            make.trailing.equalTo(productImageView.snp.trailing)
        }
    }
    
    
    private func productInfoStackViewConstraints() {
        productInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.leading.equalTo(productImageView.snp.leading)
            make.trailing.equalTo(productImageView.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
        }
    }
}
