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
    var cartCellPrice: String { get }
    var cartCellProductId: Int { get }
}

protocol CartCollectionCellInterface: AnyObject {
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, didStepperValueChanged quantity: Int)
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, didRemoveButtonTapped quantity: Int)
}

final class CartCollectionCell: UICollectionViewCell {
    deinit {
        print("deinit cartcel")
    }
    
    //MARK: - Cell's Identifier
    
    static let identifier = "CartCollectionCell"
    
    //MARK: - Creating UI Elements
    
    private var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var productTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.backgroundColor = nil
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let topStackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "mensclothings"
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$12312"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
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
    
    let stepperLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
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
    
    
    private let stepperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let bottomView: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let allInOneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        interface?.cartCollectionCell(self, productId: productId, didRemoveButtonTapped: 0)
    }
    
    //MARK: - CustomStepper Actions
    
    @objc private func stepperPlusButtonTapped(_ button: UIButton) {
        quantity = quantity + 1
        guard let productId = productId else { return }
        interface?.cartCollectionCell(self, productId: productId, didStepperValueChanged: quantity)
    }
    
    @objc private func stepperMinusButtonTapped(_ button: UIButton) {
        quantity = quantity - 1
        guard let productId = productId else { return }
        interface?.cartCollectionCell(self, productId: productId, didStepperValueChanged: quantity)
    }
    
    
    
    //MARK: - ConfigureCell
    
    func configure(data: CartCollectionCellProtocol) {
        productImage.downloadSetImage(url: data.cartCellImage)
        productTitle.text = data.cartCellTitle
        priceLabel.text = data.cartCellPrice
        productId = data.cartCellProductId
    }
    
    
    
    //MARK: - AddProductTitle/RemoveButtonToStackView
    
    private func addTitleButtonToTopView() {
        topStackView.addSubview(productTitle)
        topStackView.addSubview(removeButton)
    }
    
    //MARK: - AddCustomStepperElementsToStackView
    
    private func addStepperElementsToStackView() {
        stepperStackView.addArrangedSubview(stepperPlusButton)
        stepperStackView.addArrangedSubview(stepperLabel)
        stepperStackView.addArrangedSubview(stepperMinusButton)
    }
    
    //MARK: - AddPriceStepperElementsToStackView
    
    private func addPriceStepperToBottomStackView() {
        bottomView.addSubview(priceLabel)
        bottomView.addSubview(stepperStackView)
    }
    
    private func addAllStackViewToOne() {
        allInOneStackView.addArrangedSubview(topStackView)
        allInOneStackView.addArrangedSubview(categoryLabel)
        allInOneStackView.addArrangedSubview(bottomView)
    }
    
    
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubview(productImage)
        addSubview(allInOneStackView)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        productImageConstraints()
        addTitleButtonToTopView()
        productTitleConstraints()
        removeButtonConstraints()
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
            make.width.equalTo(topStackView.snp.width).multipliedBy(0.75)
            make.centerY.equalTo(topStackView.snp.centerY)
            make.leading.equalTo(topStackView.snp.leading)
        }
    }
    
    private func removeButtonConstraints() {
        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(productTitle.snp.centerY)
            make.trailing.equalTo(topStackView.snp.trailing)
            
        }
    }
    
    private func priceLabelConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.width.equalTo(bottomView.snp.width).multipliedBy(0.5)
            make.centerY.equalTo(bottomView.snp.centerY)
            make.leading.equalTo(bottomView.snp.leading)
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
