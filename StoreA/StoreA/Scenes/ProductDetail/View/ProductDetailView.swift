//
//  ProductDetailView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 7.01.2023.
//

import UIKit
//MARK: - ProductDetailViewInterface Protocol

protocol ProductDetailViewInterface: AnyObject {
    func productDetailView(_ view: ProductDetailView, addToCartButtonTapped button: UIButton, quantity: Int)
    func productDetailView(_ view: ProductDetailView, stepperValueChanged quantity: Int)
    func productDetailView(_ view: ProductDetailView, quantity: Int, addToWishListButtonTapped button: UIButton)
}

//MARK: - ProductDetailViewProtocol

protocol ProductDetailViewProtocol {
    var productDetailImage: String { get }
    var productDetailTitle: String { get }
    var productDetailSalesAmount: String { get }
    var productDetailRatingCount: String { get }
    var productDetailDescription: String { get }
    var productDetailPrice: String { get }
}

final class ProductDetailView: UIView {

    //MARK: - Creating UI Elements
    
    private var productImage = CustomImageView(backgroundColor: .white,contentMode: .scaleAspectFit)
    private var productTitle = CustomLabel(text: "", numberOfLines: 2, font: .boldSystemFont(ofSize: 20), textColor: .blue, textAlignment: .left)
    var addToWishListButton = CustomButton(backgroundColor: .white, image: UIImage(systemName: "wishListButton"), tintColor: .black)
    private var favButtonTitleStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 5, isHidden: false)
    private var salesAmountView = CustomView(backgroundColor: .systemGray6, cornerRadius: 12)
    private var salesAmountLabel = CustomLabel(text: "", numberOfLines: 1, font: .boldSystemFont(ofSize: 15), textColor: .black, textAlignment: .center)
    private var ratingCountImageView = CustomImageView(image: UIImage(systemName: "star.leadinghalf.filled"), tintColor: .black, backgroundColor: .white, contentMode: .scaleAspectFit, cornerRadius: 12)
    private var ratingCountLabel = CustomLabel(text: "", numberOfLines: 0, font: .systemFont(ofSize: 15), textColor: .black, textAlignment: .center)
    private var ratingCountStackView = CustomStackView(backgroundColor: .white, cornerRadius: 12, axis: .horizontal, distiribution: .fill, spacing: 2)
    private var seperatorView = CustomView(backgroundColor: .systemGray2)
    private var descriptionTitle = CustomLabel(text: "Description", numberOfLines: 0, font: .systemFont(ofSize: 17), textColor: .black, textAlignment: .left)
    private var descriptionLabel = CustomLabel(text: "", numberOfLines: 0, font: .systemFont(ofSize: 15), textColor: .black, textAlignment: .left)
    private var descriptionView = CustomView(backgroundColor: .white)
    private var seperatorView2 = CustomView(backgroundColor: .systemGray2)
    private var priceTitle = CustomLabel(text: "Total price", numberOfLines: 0, font: .systemFont(ofSize: 15), textColor: .black, textAlignment: .center)
    var priceLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 25), textColor: .black, textAlignment: .center)
    private var priceStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 4, isHidden: false)
    lazy var quantityLabel = CustomLabel(text: "Quantity", numberOfLines: 0, font: .boldSystemFont(ofSize: 15), textColor: .black, textAlignment: .center, isHidden: true)
    lazy var stepperPlusButton = CustomButton(backgroundColor: .systemGray6, cornerRadius: 20, image: UIImage(systemName: "plus"), tintColor: .black)
    lazy var stepperLabel = CustomLabel(text: "1", numberOfLines: 0, font: .boldSystemFont(ofSize: 20), textColor: .black, textAlignment: .center)
    lazy var stepperMinusButton = CustomButton(backgroundColor: .systemGray6, cornerRadius: 20, image: UIImage(systemName: "minus"), tintColor: .black)
    lazy var stepperStackView = CustomStackView(axis: .horizontal, distiribution: .fill, isHidden: true)
    private let addToCartButton = CustomButton(title: "Add to Cart", titleColor: .white, backgroundColor: .black, cornerRadius: 25, image: UIImage(systemName: "handbag.fill"), tintColor: .white, imageEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), titleEdgeInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    lazy var cartBtnPriceLblView = CustomView()
    
    
    //MARK: - Swifty
    
    var quantity = 1 {
        didSet {
            
            if quantity <= 0 {
                toggleStepperElements()
                quantity = 0
            } else if quantity > 10 {
                quantity = 10
            }
            stepperLabel.text = String(quantity)
        }
    }
    
    
    //MARK: - Properties
    weak var interface: ProductDetailViewInterface?
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview()
        setupConstraints()
        addTarget()
        toggleAddToWishListButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddAction
    
    private func addTarget() {
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        stepperPlusButton.addTarget(self, action: #selector(stepperPlusButtonTapped), for: .touchUpInside)
        stepperMinusButton.addTarget(self, action: #selector(stepperMinusButtonTapped), for: .touchUpInside)
        addToWishListButton.addTarget(self, action: #selector(addToWishListButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addToCartButtonTapped(_ button: UIButton) {
        if quantity <= 0 {
            quantity = 1
            stepperStackView.isHidden = false
            quantityLabel.isHidden = false
        }
        stepperStackView.isHidden = false
        quantityLabel.isHidden = false
        self.interface?.productDetailView(self, addToCartButtonTapped: button, quantity: quantity)
    }
    
    //MARK: - CustomStepper Actions
    
    @objc private func stepperPlusButtonTapped(_ button: UIButton) {
        quantity = quantity + 1
        interface?.productDetailView(self, stepperValueChanged: quantity)
        
    }
    
    @objc private func stepperMinusButtonTapped(_ button: UIButton) {
        quantity = quantity - 1
        interface?.productDetailView(self, stepperValueChanged: quantity)
        
    }
    
    @objc private func addToWishListButtonTapped(_ button: UIButton) {
        if addToWishListButton.isSelected == false {
            interface?.productDetailView(self, quantity: 1, addToWishListButtonTapped: button)
        } else {
            interface?.productDetailView(self, quantity: 0, addToWishListButtonTapped: button)
        }
        addToWishListButton.isSelected.toggle()
    }
    
    private func toggleStepperElements() {
        stepperStackView.isHidden = !stepperStackView.isHidden
        quantityLabel.isHidden = !quantityLabel.isHidden
    }
    
    func toggleAddToWishListButton() {
        let image = UIImage(named: "wishListButton")
        let imageFilled = UIImage(named: "wishListButton.fill")
        addToWishListButton.setImage(image, for: .normal)
        addToWishListButton.setImage(imageFilled, for: .selected)
    }
    
    func configure(data: ProductDetailViewProtocol) {
        productImage.downloadSetImage(url: data.productDetailImage)
        productTitle.text = data.productDetailTitle
        salesAmountLabel.text = data.productDetailSalesAmount
        ratingCountLabel.text = data.productDetailRatingCount
        descriptionLabel.text = data.productDetailDescription
        priceLabel.text = data.productDetailPrice
        
    }
    
}


//MARK: - UI Elements AddSubiew / Constraints

extension ProductDetailView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(productImage, favButtonTitleStackView, salesAmountView, salesAmountLabel, ratingCountStackView, seperatorView, descriptionView, quantityLabel, stepperStackView, seperatorView2,priceStackView,cartBtnPriceLblView)
        addFavBtnTitleLblToStackView()
        addRatingElementsToStackView()
        addDescriptionLabelsToView()
        addStepperElementsToStackView()
        addPriceLabelsToStackView()
        addCartBtnPriceLblToStackView()
    }
    
    private func addFavBtnTitleLblToStackView() {
        favButtonTitleStackView.addArrangedSubviews(productTitle, addToWishListButton)
    }
    
    
    private func addRatingElementsToStackView() {
        ratingCountStackView.addArrangedSubviews(ratingCountImageView, ratingCountLabel)
    }
    
    private func addAmountLabelToStackView() {
        salesAmountView.addSubview(salesAmountLabel)
    }
    
    private func addDescriptionLabelsToView() {
        descriptionView.addSubviews(descriptionTitle, descriptionLabel)
    }
    
    private func addPriceLabelsToStackView() {
        priceStackView.addArrangedSubviews(priceTitle, priceLabel)
    }
    
    private func addCartBtnPriceLblToStackView() {
        cartBtnPriceLblView.addSubviews(priceStackView, addToCartButton)
    }
    
    private func addStepperElementsToStackView() {
        stepperStackView.addArrangedSubviews(stepperPlusButton, stepperLabel, stepperMinusButton)
    }
    
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        productImageConstraintsh()
        favButtonConstraints()
        favTitleButtonStackViewConstraints()
        salesAmountViewConstraints()
        salesAmountLabelConstraints()
        ratingCountStackViewConstraints()
        seperatorViewConstraints()
        descriptionViewConstraints()
        descriptionTitleConstraints()
        descriptionLabelConstraints()
        quantityLabelConstraints()
        stepperPlusButtonConstraints()
        stepperMinusButtonConstraints()
        stepperElementsStackViewConstraints()
        seperatorView2Constraints()
        addToCartButtonConstraints()
        priceStackViewConstraints()
        cartBtnPriceLblViewConstraints()
    }
    
    
    //MARK: - UI Elements Constraints
    
    private func productImageConstraintsh() {
        productImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY).offset(-50)
        }
    }
    
    private func favButtonConstraints() {
        addToWishListButton.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
    }
    
    private func favTitleButtonStackViewConstraints() {
        favButtonTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(addToWishListButton.snp.bottom)
        }
    }
    
    private func salesAmountViewConstraints() {
        salesAmountView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(35)
            make.top.equalTo(favButtonTitleStackView.snp.bottom).offset(10)
            make.leading.equalTo(favButtonTitleStackView.snp.leading)
        }
    }
    
    private func salesAmountLabelConstraints() {
        salesAmountLabel.snp.makeConstraints { make in
            make.centerX.equalTo(salesAmountView.snp.centerX)
            make.centerY.equalTo(salesAmountView.snp.centerY)
        }
    }
    
    private func ratingCountStackViewConstraints() {
        ratingCountStackView.snp.makeConstraints { make in
            make.centerY.equalTo(salesAmountView.snp.centerY)
            make.leading.equalTo(salesAmountView.snp.trailing).offset(10)
        }
    }
    
    private func seperatorViewConstraints() {
        seperatorView.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionView.snp.top).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(0.75)
        }
    }
    
    private func descriptionViewConstraints() {
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(salesAmountView.snp.bottom).offset(20)
            make.leading.equalTo(seperatorView.snp.leading)
            make.trailing.equalTo(seperatorView.snp.trailing)
            make.bottom.equalTo(seperatorView2.snp.top).offset(-10)
        }
    }
    
    private func descriptionTitleConstraints() {
        descriptionTitle.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.top.equalTo(descriptionView.snp.top)
            make.leading.equalTo(descriptionView.snp.leading)
        }
    }
    
    private func descriptionLabelConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(10)
            make.leading.equalTo(descriptionView.snp.leading)
            make.trailing.equalTo(descriptionView.snp.trailing)
            make.height.lessThanOrEqualTo(descriptionView.snp.height).offset(-67)
        }
    }
    
    private func quantityLabelConstraints() {
        quantityLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionView.snp.leading)
            make.bottom.equalTo(seperatorView2.snp.top).offset(-20)
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
    
    private func stepperElementsStackViewConstraints() {
        stepperStackView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.centerY.equalTo(quantityLabel.snp.centerY)
            make.leading.equalTo(quantityLabel.snp.trailing).offset(10)
        }
    }
    
    private func seperatorView2Constraints() {
        seperatorView2.snp.makeConstraints { make in
            make.bottom.equalTo(cartBtnPriceLblView.snp.top).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(0.75)
        }
    }
    
    private func priceStackViewConstraints() {
        priceStackView.snp.makeConstraints { make in
            make.leading.equalTo(cartBtnPriceLblView.snp.leading)
            make.centerY.equalTo(cartBtnPriceLblView.snp.centerY)
        }
    }
    
    private func addToCartButtonConstraints() {
        addToCartButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.trailing.equalTo(cartBtnPriceLblView.snp.trailing)
            make.centerY.equalTo(cartBtnPriceLblView.snp.centerY)
        }
    }
    
    private func cartBtnPriceLblViewConstraints() {
        cartBtnPriceLblView.snp.makeConstraints { make in
            make.height.equalTo(addToCartButton.snp.height)
            make.leading.equalTo(seperatorView2.snp.leading)
            make.trailing.equalTo(seperatorView2.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
    
}
