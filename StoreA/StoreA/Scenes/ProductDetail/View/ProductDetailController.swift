//
//  ProductDetailController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 7.01.2023.
//

import UIKit


final class ProductDetailController: UIViewController {

    //MARK: - Properties
    private let productDetailViewModel = ProductDetailViewModel()
    private let productDetailView = ProductDetailView()
    var product: Product
    
    //MARK: - Init
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
        productDetailView.interface = self
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
  
    
    //MARK: - ConfigureViewControler
    
    private func configureViewController() {
        view = productDetailView
        productDetailView.configure(data: product)
    }

}

extension ProductDetailController: ProductDetailViewInterface {
    func productDetailView(_ view: ProductDetailView, didTapAddToCartButton button: UIButton) {
        guard let id = product.id else { return }
        productDetailViewModel.updateCart(productId: id)
    }
    
    
}



