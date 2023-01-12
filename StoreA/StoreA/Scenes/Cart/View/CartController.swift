//
//  CartController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import UIKit

final class CartController: UIViewController {
   
    deinit {
        print("deinit cart controller")
    }
    
    //MARK: - Properties
    private let cartViewModel = CartViewModel()
    private let cartView = CartView()


    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Cart"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        configureViewController()
        collectionCellRegister()
        setupDelegates()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cartViewModel.fetchCart()
        cartView.priceLabel.text = "$\(cartViewModel.totalCost)"
    }
    
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        view = cartView
    }
    
    //MARK: -  Register Custom Cell
    
    private func collectionCellRegister() {
        cartView.cartCollection.register(CartCollectionCell.self, forCellWithReuseIdentifier: "CartCollectionCell")
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        cartViewModel.delegate = self
        
        cartView.cartCollection.delegate = self
        cartView.cartCollection.dataSource  = self
    }



}

extension CartController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartViewModel.cartsProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cartView.cartCollection.dequeueReusableCell(withReuseIdentifier: "CartCollectionCell", for: indexPath) as? CartCollectionCell else { return UICollectionViewCell()}
        cell.interface = self
        let product = cartViewModel.cartsProducts[indexPath.row]
        if let stepperLabel = cartViewModel.cart?["\(product.id)"] {
            cell.stepperLabel.text = "\(stepperLabel)"
        }
        cell.configure(data: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cartView.cartCollection.frame.width - 30, height: 150)
    }
    
    
}

//MARK: - CartCollectionCellInterface

extension CartController: CartCollectionCellInterface {
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, didStepperValueChanged quantity: Int) {
        if quantity == 0 {
            let indexPath = cartViewModel.getProductIndexPath(productId: productId)
            cartViewModel.removeProduct(index: indexPath.row)
            cartView.cartCollection.deleteItems(at: [indexPath])
        }
        cartViewModel.updateCart(productId: productId, quantity: quantity)
    }
    
    
}

//MARK: - CartViewModelDelegate

extension CartController: CartViewModelDelegate {
   
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateCartSuccessful() {
        cartViewModel.fetchCart()
    }
    
    func didFetchProductsFromCartSuccessful() {
        cartView.cartCollection.reloadData()
    }
    
    func didFetchCostAccToItemCount() {
        cartView.priceLabel.text = "$\(cartViewModel.totalCost)"
    }
    
    
}
