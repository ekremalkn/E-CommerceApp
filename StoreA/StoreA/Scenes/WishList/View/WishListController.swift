//
//  WishListController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 13.01.2023.
//

import UIKit

final class WishListController: UIViewController {
    
    deinit {
        print("deinit wishlistcontroller")
    }
    
    //MARK: - Properties
    private let wishListViewModel = WishListViewModel()
    private let wishListView = WishListView()
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavBar()
        collectionCellRegister()
        setupDelegates()
        wishListViewModel.fetchWishList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK: - ConfigureViewController
    
    private func configureViewController() {
        title = "My Wishlist"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        view = wishListView
    }
    
    
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    //MARK: - Register Custom Cell
    
    private func collectionCellRegister() {
        wishListView.wishListCollection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        wishListViewModel.delegate = self
        
        wishListView.wishListCollection.delegate = self
        wishListView.wishListCollection.dataSource = self
    }
    
}


extension WishListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishListViewModel.wishListProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = wishListView.wishListCollection.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else { return UICollectionViewCell()}
        cell.interface = self
        cell.addToWishListButton.isSelected = true
        cell.configure(data: wishListViewModel.wishListProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = wishListViewModel.wishListProducts[indexPath.row].id else { return }
        wishListViewModel.fetchSingleProduct(productId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: wishListView.wishListCollection.frame.width / 2 - 10, height: wishListView.wishListCollection.frame.width / 2)
    }
    
    
}

extension WishListController: ProductCollectionCellInterface {
    func productCollectionCell(_ view: ProductCollectionCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton) {
        let indexPath = wishListViewModel.getProductIndexPath(productId: productId)
        wishListViewModel.removeProduct(index: indexPath.row)
        wishListView.wishListCollection.deleteItems(at: [indexPath])
        wishListViewModel.updateWishList(productId: productId, quantity: 0)
    }
    
    
}

extension WishListController: WishListViewModelDelegate {
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didUpdateWishListSuccessful() {
        wishListViewModel.fetchWishList()
    }
    
    func didFetchProductsFromWishListSuccessful() {
        wishListView.wishListCollection.reloadData()
    }
    
    func didFetchSingleProduct(_ product: Product) {
        let controller = ProductDetailController(product: product)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didFetchQuantity() {
    }
    
}
