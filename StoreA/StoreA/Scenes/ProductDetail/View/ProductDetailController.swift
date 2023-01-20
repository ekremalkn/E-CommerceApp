//
//  ProductDetailController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 7.01.2023.
//

import UIKit


final class ProductDetailController: UIViewController {

    //MARK: - Properties
    private let productsViewModel = ProductsViewModel()
    private let productDetailViewModel = ProductDetailViewModel()
    private let productDetailView = ProductDetailView()
    var product: Product
    
    //MARK: - Init methods
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        if let productId = product.id {
            productDetailViewModel.fetchCart(productId: productId)
            productDetailViewModel.fetchWishList(productId: productId)
        }
    }
    
    
    //MARK: - ConfigureViewControler
    
    private func configureViewController() {
        view = productDetailView
        productDetailView.configure(data: product)
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        productDetailView.interface = self
        
        productDetailViewModel.delegate = self
    }

    
}

//MARK: - ProductDetailViewModelDelegate

extension ProductDetailController: ProductDetailViewModelDelegate {
   
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateCartSuccessful(quantity: Int) {
        if let productId = product.id {
            productDetailViewModel.fetchCart(productId: productId)
        }
        
    }
    
    func didFetchCartCountSuccessful() {
        if let cartCount = productDetailViewModel.cart?.count {
            if cartCount == 0 {
                tabBarController?.tabBar.items?[2].badgeValue = nil
            } else {
                tabBarController?.tabBar.items?[2].badgeValue = "\(cartCount)"
            }
        }
    }
    
    func didFetchCartCostSuccessful(productId: Int, quantity: Int) {
        if let cost = productDetailViewModel.cartCost {
            productDetailView.priceLabel.text = "$\(cost)"
            productDetailView.stepperStackView.isHidden = false
            productDetailView.quantityLabel.isHidden = false
            productDetailView.quantity = quantity
        } else {
            productDetailView.stepperStackView.isHidden = true
            productDetailView.quantityLabel.isHidden = true
        }
        
    }
    
    func didFetchWishListSuccessful(productId: Int) {
        if productId == product.id {
            productDetailView.addToWishListButton.isSelected = true
        } else {
            productDetailView.addToWishListButton.isSelected = false
            
        }
    }
    
    
}

//MARK: - ProductDetailViewInterface

extension ProductDetailController: ProductDetailViewInterface {
    func productDetailView(_ view: ProductDetailView, quantity: Int, addToWishListButtonTapped button: UIButton) {
        guard let id = product.id else { return }
        productsViewModel.updateWishList(productId: id, quantity: quantity)
    }
    
    
    func productDetailView(_ view: ProductDetailView, addToCartButtonTapped button: UIButton, quantity: Int) {
        guard let id = product.id else { return }
        productDetailViewModel.updateCart(productId: id, quantity: quantity)
        
    }
    
    func productDetailView(_ view: ProductDetailView, stepperValueChanged quantity: Int) {
        guard let id = product.id else { return }
        productDetailViewModel.updateCart(productId: id, quantity: quantity)
    }
    
}



