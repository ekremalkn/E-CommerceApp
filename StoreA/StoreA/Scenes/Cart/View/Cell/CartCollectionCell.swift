//
//  CartCollectionCell.swift
//  StoreA
//
//  Created by Ekrem Alkan on 10.01.2023.
//

import UIKit

protocol CartCollectionCellProtocol {
    var cartCellImage: String { get }
    var cartCellTitle: String { get }
    var cartCellCategory: String { get }
    var cartCellPrice: String { get }
    var cartCellProductId: Int { get }
}

protocol CartCollectionCellInterface: AnyObject {
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, stepperValueChanged quantity: Int)
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, removeButtonTapped quantity: Int)
}

final class CartCollectionCell: UICollectionViewCell {
    deinit {
        print("deinit cartcel")
    }
    
    //MARK: - Cell's Identifier
    
    static let identifier = "CartCollectionCell"
    
    //MARK: - Creating UI Elements
    
    private var productImage = CustomImageView(image: UIImage(systemName: "exclamationmark.circle")!, tintColor: .black, backgroundColor: .white, contentMode: .scaleAspectFit, cornerRadius: 0, isUserInteractionEnabled: false)
    private var productTitle = CustomLabel(text: "", numberOfLines: 1, font: .boldSystemFont(ofSize: 15), textColor: .black, textAlignment: .left)
    private var removeButton = CustomButton(image: UIImage(systemName: "trash"),tintColor: .gray)
    private var topView = CustomView(backgroundColor: .white, cornerRadius: 0)
    private var categoryLabel = CustomLabel(text: "mensclothings", numberOfLines: 1, font: .systemFont(ofSize: 10), textColor: .gray, textAlignment: .left)
    private var priceLabel = CustomLabel(text: "", numberOfLines: 1, font: .boldSystemFont(ofSize: 18), textColor: .black, textAlignment: .left)
    private var stepperPlusButton = CustomButton(backgroundColor: .systemGray6, cornerRadius: 20, image: UIImage(systemName: "plus"), tintColor: .black)
    private var stepperLabel = CustomLabel(text: "1", numberOfLines: 0, font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .center)
    private var stepperMinusButton = CustomButton(backgroundColor: .systemGray6, cornerRadius: 20, image: UIImage(systemName: "minus"), tintColor: .black)
    private var stepperStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 5, isHidden: false)
    private var bottomView = CustomView(backgroundColor: .white, cornerRadius: 0)
    private var allInOneStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 0, isHidden: false)
    
    
    var productId: Int?
    
    //MARK: - Properties
    
    weak var interface: CartCollectionCellInterface?
    
    //MARK: - Swifty
    
    var quantity = 1 {
        didSet {
            if quantity <= 0 {
                quantity = 0
            } else if quantity > 10 {
                quantity = 10
            }
            stepperLabel.text = String(quantity)
        }
    }
    
    //MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        addSubview()
        setupConstraints()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddAction
    
    private func addTarget() {
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        stepperMinusButton.addTarget(self, action: #selector(stepperMinusButtonTapped), for: .touchUpInside)
        stepperPlusButton.addTarget(self, action: #selector(stepperPlusButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func removeButtonTapped(_ button: UIButton) {
        guard let productId = productId else { return }
        interface?.cartCollectionCell(self, productId: productId, removeButtonTapped: 0)
    }
    
    //MARK: - CustomStepper Actions
    
    @objc private func stepperPlusButtonTapped(_ button: UIButton) {
        quantity = quantity + 1
        guard let productId = productId else { return }
        interface?.cartCollectionCell(self, productId: productId, stepperValueChanged: quantity)
    }
    
    @objc private func stepperMinusButtonTapped(_ button: UIButton) {
        quantity = quantity - 1
        guard let productId = productId else { return }
        interface?.cartCollectionCell(self, productId: productId, stepperValueChanged: quantity)
    }
    
    
    
    //MARK: - ConfigureCell
    
    func configure(data: CartCollectionCellProtocol) {
        productImage.downloadSetImage(url: data.cartCellImage)
        productTitle.text = data.cartCellTitle
        categoryLabel.text = data.cartCellCategory
        priceLabel.text = data.cartCellPrice
        productId = data.cartCellProductId
    }
    
    
    
    //MARK: - AddProductTitle/RemoveButtonToStackView
    
    private func addTitleButtonToTopView() {
        topView.addSubview(productTitle)
        topView.addSubview(removeButton)
    }
    
    //MARK: - AddCustomStepperElementsToStackView
    
    private func addStepperElementsToStackView() {
        stepperStackView.addArrangedSubviews(stepperPlusButton, stepperLabel, stepperMinusButton)
    }
    
    //MARK: - AddPriceStepperElementsToStackView
    
    private func addPriceStepperToBottomStackView() {
        bottomView.addSubviews(priceLabel, stepperStackView)
    }
    
    private func addAllStackViewToOne() {
        allInOneStackView.addArrangedSubviews(topView, categoryLabel, bottomView)
    }
    
    
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(productImage, allInOneStackView)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        productImageConstraints()
        addTitleButtonToTopView()
        productTitleConstraints()
        removeButtonConstraints()
        stepperPlusButtonConstraints()
        stepperMinusButtonConstraints()
        addStepperElementsToStackView()
        addPriceStepperToBottomStackView()
        priceLabelConstraints()
        stepperStackViewConstraints()
        addAllStackViewToOne()
        allInOneStackViewConstraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func productImageConstraints() {
        productImage.snp.makeConstraints { make in
            make.height.width.equalTo(120)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
        }
    }
    
    private func productTitleConstraints() {
        productTitle.snp.makeConstraints { make in
            make.width.equalTo(topView.snp.width).multipliedBy(0.75)
            make.centerY.equalTo(topView.snp.centerY)
            make.leading.equalTo(topView.snp.leading)
        }
    }
    
    private func removeButtonConstraints() {
        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(productTitle.snp.centerY)
            make.trailing.equalTo(topView.snp.trailing)
            
        }
    }
    
    private func priceLabelConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.width.equalTo(bottomView.snp.width).multipliedBy(0.5)
            make.centerY.equalTo(bottomView.snp.centerY)
            make.leading.equalTo(bottomView.snp.leading)
        }
    }
    
    private func stepperPlusButtonConstraints() {
        stepperPlusButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    private func stepperMinusButtonConstraints() {
        stepperMinusButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    private func stepperStackViewConstraints() {
        stepperStackView.snp.makeConstraints { make in
            make.width.equalTo(bottomView.snp.width).multipliedBy(0.5)
            make.height.equalTo(bottomView.snp.height)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.trailing.equalTo(bottomView.snp.trailing)
        }
    }
    
    private func allInOneStackViewConstraints() {
        allInOneStackView.snp.makeConstraints { make in
            make.height.equalTo(productImage)
            make.leading.equalTo(productImage.snp.trailing).offset(10)
            make.centerY.equalTo(productImage.snp.centerY)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
    }
    
    
    
    
    
    
}
