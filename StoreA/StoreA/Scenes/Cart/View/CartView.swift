//
//  CartView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 10.01.2023.
//

import UIKit

protocol CartViewInterface: AnyObject {
    func cartView(_ view: CartView, checkoutButtonTapped button: UIButton )
    
}

final class CartView: UIView {
    deinit {
        print("CartView deinit")
    }
    weak var interface: CartViewInterface?
    
    //MARK: - Creating UI Elements
    
    var cartCollection = CustomCollection(backgroundColor: .systemGray6, showsScrollIndicator: false ,layout: UICollectionViewFlowLayout(), scrollDirection: .vertical)
    private var checkoutView = CustomView(backgroundColor: .white, clipsToBound: true, cornerRadius: 35, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    private var priceTitle = CustomLabel(text: "Total price", numberOfLines: 0, font: .systemFont(ofSize: 15), textColor: .gray, textAlignment: .left)
    var priceLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 25), textColor: .black, textAlignment: .center)
    private var priceStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 0, isHidden: false)
    private var checkoutButton = CustomButton(title: "Checkout", titleColor: .white, backgroundColor: .black, cornerRadius: 25, image: UIImage(systemName: "checkmark.shield.fill"), tintColor: .white, imageEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), titleEdgeInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    
    //MARK: - Init methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubview()
        setupConstraints()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Add Action
    
    private func addTarget() {
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkoutButtonTapped(_ button: UIButton) {
        interface?.cartView(self, checkoutButtonTapped: button)
    }
    
    
}

//MARK: - UI Elements AddSubiew / Constraints

extension CartView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(cartCollection, checkoutView)
    }
    
    private func addPriceLabelsToStackView() {
        priceStackView.addArrangedSubviews(priceTitle, priceLabel)
    }
    
    private func addCheckoutElementsToCheckoutView() {
        checkoutView.addSubviews(priceStackView, checkoutButton)
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
            make.height.equalTo(checkoutButton.snp.height).multipliedBy(2)
        }
    }
    
    private func priceStackViewConstraints() {
        priceStackView.snp.makeConstraints { make in
            make.leading.equalTo(checkoutView.snp.leading).offset(10)
            make.centerY.equalTo(checkoutView.snp.centerY)
            make.height.equalTo(56)
        }
    }
    
    private func checkoutButtonConstraints() {
        checkoutButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(56)
            make.trailing.equalTo(checkoutView.snp.trailing).offset(-10)
            make.centerY.equalTo(checkoutView.snp.centerY)
        }
    }
    
    
    
    
    
}
