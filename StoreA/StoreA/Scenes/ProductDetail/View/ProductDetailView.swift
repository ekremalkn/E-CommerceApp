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
    deinit {
        print("deinit productdetail view")
    }

    //MARK: - Creating UI Elements

    private var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var productTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favButtonTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    
    private var salesAmountView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private var salesAmountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingCountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var ratingCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 12
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
        return stackView
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let  descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let seperatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
    private let priceTitle: UILabel = {
        let label = UILabel()
        label.text = "Total price"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
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
        stackView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return stackView
    }()
    
     var quantityLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "Quantity"
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stepperPlusButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.backgroundColor = .systemGray6
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        return button
    }()
    
    private let stepperLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepperMinusButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.backgroundColor = .systemGray6
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        return button
    }()
    
    
     let stepperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isHidden = true
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        return stackView
    }()
    
     private let addToCartButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .black
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "handbag.fill"), for: .normal)
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
    
    private let cartBtnPriceLblStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing =  0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - AddAction
    
    private func addTarget() {
        addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        stepperPlusButton.addTarget(self, action: #selector(stepperPlusButtonTapped), for: .touchUpInside)
        stepperMinusButton.addTarget(self, action: #selector(stepperMinusButtonTapped), for: .touchUpInside)
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
    
    private func toggleStepperElements() {
        stepperStackView.isHidden = !stepperStackView.isHidden
        quantityLabel.isHidden = !quantityLabel.isHidden
    }
    
     func configure(data: ProductDetailViewProtocol) {
        productImage.downloadSetImage(url: data.productDetailImage)
        productTitle.text = data.productDetailTitle
        salesAmountLabel.text = data.productDetailSalesAmount
        ratingCountLabel.text = data.productDetailRatingCount
        descriptionLabel.text = data.productDetailDescription
        priceLabel.text = data.productDetailPrice
        
    }
    
    //MARK: - AddFavButtonTitleLabelToStackView

    private func addFavBtnTitleLblToStackView() {
        favButtonTitleStackView.addArrangedSubview(productTitle)
        favButtonTitleStackView.addArrangedSubview(favButton)
    }
    
    //MARK: - AddRatingElementsToStackView
    
    private func addRatingElementsToStackView() {
        ratingCountStackView.addArrangedSubview(ratingCountImageView)
        ratingCountStackView.addArrangedSubview(ratingCountLabel)
    }
    
    //MARK: - AddAmountLabelToStackView
    
    private func addAmountLabelToStackView() {
        salesAmountView.addSubview(salesAmountLabel)
    }

    
    //MARK: - AddDescriptonLabelsToStackView
    
    private func addDescriptionLabelsToView() {
        descriptionView.addSubview(descriptionTitle)
        descriptionView.addSubview(descriptionLabel)
    }

    //MARK: - AddPriceLabelsToStackView
    
    private func addPriceLabelsToStackView() {
        priceStackView.addArrangedSubview(priceTitle)
        priceStackView.addArrangedSubview(priceLabel)
    }
    
    //MARK: - AddCartBtnPriceLabelsToStackView
    
    private func addCartBtnPriceLblToStackView() {
        cartBtnPriceLblStackView.addArrangedSubview(priceStackView)
        cartBtnPriceLblStackView.addArrangedSubview(addToCartButton)
    }
    
    //MARK: - AddCustomStepperElementsToStackView

    private func addStepperElementsToStackView() {
        stepperStackView.addArrangedSubview(stepperPlusButton)
        stepperStackView.addArrangedSubview(stepperLabel)
        stepperStackView.addArrangedSubview(stepperMinusButton)
    }

}


extension ProductDetailView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubview(productImage)
        addSubview(favButtonTitleStackView)
        addFavBtnTitleLblToStackView()
        addSubview(salesAmountView)
        addSubview(salesAmountLabel)
        addSubview(ratingCountStackView)
        addRatingElementsToStackView()
        addSubview(seperatorView)//0.75 height
        addSubview(descriptionView)
        addDescriptionLabelsToView()
        addSubview(quantityLabel)
        addSubview(stepperStackView)
        addStepperElementsToStackView()
        addSubview(seperatorView2)//0.75 height
        addSubview(priceStackView)
        addPriceLabelsToStackView()
        addSubview(cartBtnPriceLblStackView)
        addCartBtnPriceLblToStackView()
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
        stepperElementsStackViewConstraints()
        seperatorView2Constraints()
        cartBtnPriceLblStackViewConstraints()
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
        favButton.snp.makeConstraints { make in
            make.width.equalTo(45)
        }
    }
    
    private func favTitleButtonStackViewConstraints() {
        favButtonTitleStackView.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(favButton.snp.bottom)
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
    
    private func stepperElementsStackViewConstraints() {
        stepperStackView.snp.makeConstraints { make in
            make.centerY.equalTo(quantityLabel.snp.centerY)
            make.leading.equalTo(quantityLabel.snp.trailing).offset(10)
        }
    }
    
    private func seperatorView2Constraints() {
        seperatorView2.snp.makeConstraints { make in
            make.bottom.equalTo(cartBtnPriceLblStackView.snp.top).offset(-10)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(0.75)
        }
    }
    

    private func cartBtnPriceLblStackViewConstraints() {
        cartBtnPriceLblStackView.snp.makeConstraints { make in
            make.height.equalTo(addToCartButton.snp.height)
            make.leading.equalTo(seperatorView2.snp.leading)
            make.trailing.equalTo(seperatorView2.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
    
}
