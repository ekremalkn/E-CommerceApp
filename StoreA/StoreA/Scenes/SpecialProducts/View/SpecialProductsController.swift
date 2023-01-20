//
//  SpecialProductsController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit

final class SpecialProductsController: UIViewController {

    //MARK: - Properties
    private let specialProductsViewModel = SpecialProductsViewModel()
    private let specialProductsView = SpecialProductsView()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavBar()
        collectionCellRegister()
        setupDelegates()
        specialProductsViewModel.fetchSpecialProducts()
    }
    
    //MARK: - ConfigureViewController
    
    private func configureViewController() {
        title = "Special Products"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        view = specialProductsView
    }
    
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    //MARK: - Register Custom Cell
    
    private func collectionCellRegister() {
        specialProductsView.specialProductsCollection.register(SpecialCollectionCell.self, forCellWithReuseIdentifier: SpecialCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        specialProductsViewModel.delegate = self
        
        specialProductsView.specialProductsCollection.delegate = self
        specialProductsView.specialProductsCollection.dataSource = self
    }
    
    
    
}

extension SpecialProductsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specialProductsViewModel.specialProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = specialProductsView.specialProductsCollection.dequeueReusableCell(withReuseIdentifier: SpecialCollectionCell.identifier, for: indexPath) as? SpecialCollectionCell else { return UICollectionViewCell()}
        cell.configure(data: specialProductsViewModel.specialProducts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = specialProductsViewModel.specialProducts[indexPath.row].id else { return }
        specialProductsViewModel.fetchSingleProduct(productId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: specialProductsView.specialProductsCollection.frame.width, height: specialProductsView.specialProductsCollection.frame.width / 2 - 10)
    }
    
}

extension SpecialProductsController: SpecialProductsViewModelDelegate {
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchSpecialProductsSuccessful() {
        specialProductsView.specialProductsCollection.reloadData()
    }
    
    func didFetchSingleProduct(_ product: Product) {
        let controller = ProductDetailController(product: product)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
