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
        title = "Cart"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        view = cartView
    }
    
    //MARK: -  Register Custom Cell
    
    private func collectionCellRegister() {
        cartView.cartCollection.register(CartCollectionCell.self, forCellWithReuseIdentifier: CartCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        cartViewModel.delegate = self
        
        cartView.cartCollection.delegate = self
        cartView.cartCollection.dataSource  = self
    }
    
    
    
}

//MARK: - CollectionView Methods

extension CartController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartViewModel.cartsProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cartView.cartCollection.dequeueReusableCell(withReuseIdentifier: CartCollectionCell.identifier, for: indexPath) as? CartCollectionCell else { return UICollectionViewCell()}
        cell.interface = self
        if let productId = cartViewModel.cartsProducts[indexPath.row].id {
            if let quantity = cartViewModel.cart?["\(productId)"] {
                cell.quantity = quantity
            }
        }
        cell.configure(data: cartViewModel.cartsProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = cartViewModel.cartsProducts[indexPath.row].id else { return }
        cartViewModel.fetchSingleProduct(productId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cartView.cartCollection.frame.width - 30, height: 150)
    }
    
    
}

//MARK: - CartCollectionCellInterface

extension CartController: CartCollectionCellInterface {
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, stepperValueChanged quantity: Int) {
        if quantity == 0 {
            let indexPath = cartViewModel.getProductIndexPath(productId: productId)
            cartView.cartCollection.deleteItems(at: [indexPath])
            cartViewModel.removeProduct(index: indexPath.row)
        }
        cartViewModel.updateCart(productId: productId, quantity: quantity)
    }
    
    func cartCollectionCell(_ view: CartCollectionCell, productId: Int, removeButtonTapped quantity: Int) {
        let indextPath = cartViewModel.getProductIndexPath(productId: productId)
        cartView.cartCollection.deleteItems(at: [indextPath])
        cartViewModel.removeProduct(index: indextPath.row)
        cartViewModel.updateCart(productId: productId, quantity: 0)
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
    
    func didFetchSingleProduct(_ product: Product) {
        let controller = ProductDetailController(product: product)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
