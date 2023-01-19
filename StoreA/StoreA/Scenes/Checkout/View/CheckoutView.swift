//
//  CheckoutView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 19.01.2023.
//

import UIKit

final class CheckoutView: UIView {
    
    //MARK: - CheckoutModel Array
    
    var checkoutModel: [CheckoutModel] = []

    //MARK: - Creating UI Elements
    
    private var customGrabber = CustomView(backgroundColor: .systemGray4, cornerRadius: 5)
    private var imageView = CustomImageView(image: UIImage(systemName: "cart.fill"), tintColor: .white, contentMode: .scaleAspectFit)
    private var viewForImage = CustomView(backgroundColor: .black, cornerRadius: 75)
    private var label1 = CustomLabel(text: "Order Successful!", numberOfLines: 0, font: .boldSystemFont(ofSize: 18), textColor: .black, textAlignment: .center)
    private var label2 = CustomLabel(text: "You have successfully made order", numberOfLines: 0, font: .systemFont(ofSize: 14), textColor: .black, textAlignment: .center)
    private var labelStackView = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 15)

    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setCheckoutModel()
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure() {
        imageView.image = checkoutModel[0].image
        label1.text = checkoutModel[0].label1
        label2.text = checkoutModel[0].label2
    }
    
    
    func setCheckoutModel() {
        checkoutModel = [CheckoutModel(image: UIImage(systemName: "cart.fill.badge.questionmark")!, label1: "Your cart is currently empty", label2: "You can checkout when there is a product in your cart.")]
    }

    


}

//MARK: - UI Elements Constraints

extension CheckoutView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubviews(customGrabber, viewForImage, labelStackView)
        addImageViewToView()
        addLabelsToStackView()
    }
    
    private func addImageViewToView() {
        viewForImage.addSubview(imageView)
    }
    
    private func addLabelsToStackView() {
        labelStackView.addArrangedSubviews(label1, label2)
    }

    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        grabberConstraints()
        viewForImageConstraints()
        imageViewConstraints()
        labelStackViewConstraints()
    }
    
    private func grabberConstraints() {
        customGrabber.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.height.equalTo(customGrabber.snp.width).multipliedBy(0.05)
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func viewForImageConstraints() {
        viewForImage.snp.makeConstraints { make in
            make.top.equalTo(customGrabber.snp.bottom).offset(10)
            make.centerX.equalTo(customGrabber.snp.centerX)
            make.height.width.equalTo(150)
        }
        
    }
    
    private func imageViewConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(viewForImage)
            make.height.width.equalTo(75)
        }
    }

    private func labelStackViewConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(viewForImage.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-15)
        }
    }



}
