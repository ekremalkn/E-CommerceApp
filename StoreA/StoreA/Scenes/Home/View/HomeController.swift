//
//  HomeController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import UIKit

final class HomeController: UIViewController {
    
    deinit {
        print("deinit home controller")
    }
    
    //MARK: - Properties
    private let productsViewModel = ProductsViewModel()
    private let homeView = HomeView()

    //MARK: -  Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        collectionCellRegister()
        setupDelegates()
        productsViewModel.fetchAllProducts()
        productsViewModel.fetchOnlyCategory()
    }
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        title = "Home"
        view = homeView
    }
    
    
    //MARK: - Register Custom Cell
    
    private func collectionCellRegister() {
        homeView.specialCollection.register(SpecialCollectionCell.self, forCellWithReuseIdentifier: "SpecialCollectionCell")
        homeView.categoryCollection.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        homeView.productCollection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        productsViewModel.delegate = self
        
        homeView.interface = self
        homeView.searcBar.delegate = self
        
        homeView.specialCollection.delegate = self
        homeView.specialCollection.dataSource = self
        homeView.categoryCollection.delegate = self
        homeView.categoryCollection.dataSource = self
        homeView.productCollection.delegate = self
        homeView.productCollection.dataSource = self
    }
  
}

//MARK: - SerchBar Methods

extension HomeController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
     let searchVC = SearchController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}


//MARK: - CollectionViews Methods

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case homeView.specialCollection:
            return productsViewModel.products.count
        case homeView.categoryCollection:
            return productsViewModel.allCategories.count
        case homeView.productCollection:
            return productsViewModel.products.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case homeView.specialCollection:
            guard let cell = homeView.specialCollection.dequeueReusableCell(withReuseIdentifier: "SpecialCollectionCell", for: indexPath) as? SpecialCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsViewModel.products[indexPath.row])
            return cell
        case homeView.categoryCollection:
            guard let cell = homeView.categoryCollection.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as? CategoryCollectionCell else { return UICollectionViewCell()}
            cell.configure(data: productsViewModel.allCategories, indexPath: indexPath)
            return cell
        case homeView.productCollection:
            guard let cell = homeView.productCollection.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as? ProductCollectionCell else { return UICollectionViewCell()}
            cell.interface = self
            cell.configure(data: productsViewModel.products[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case homeView.specialCollection:
            guard let productId = productsViewModel.products[indexPath.row].id else { return }
            productsViewModel.fetchSingleProduct(productId: productId)
        case homeView.categoryCollection:
                let category = productsViewModel.allCategories[indexPath.row]
                productsViewModel.fetchProductByCategory(category)
        case homeView.productCollection:
            guard let productId = productsViewModel.products[indexPath.row].id else { return }
            productsViewModel.fetchSingleProduct(productId: productId)
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case homeView.specialCollection:
            return CGSize(width: homeView.specialCollection.frame.width - 10, height:homeView.specialCollection.frame.height)
        case homeView.categoryCollection:
            return CGSize(width: homeView.categoryCollection.frame.width / 3, height: homeView.categoryCollection.frame.height / 1.25)
        case homeView.productCollection:
            return CGSize(width: homeView.productCollection.frame.width / 2 - 10, height: homeView.productCollection.frame.width / 2 )
        default:
            return CGSize(width: 20, height: 20)
        }
    }
    
}

extension HomeController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width
            homeView.currentPage = Int(scrollView.contentOffset.x / witdh)
    }
}

extension HomeController: HomeViewInterface {
    func homeView(_ view: HomeView, cartButtonTapped button: UIButton) {
        let cartVC = CartController()
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    func homeView(_ view: HomeView, wishListButtonTapped button: UIButton) {
        let wishListVC = WishListController()
        navigationController?.pushViewController(wishListVC, animated: true)
    }
    
    func homeView(_ view: HomeView, seeAllButtonTapped button: UIButton) {
        let specialProductsVC = SpecialProductsController()
        navigationController?.pushViewController(specialProductsVC, animated: true)
    }
    
    
}



//MARK: - ProductsViewModelDelegate

extension HomeController: ProductsViewModelDelegate {
    func didFetchSingleProduct(_ product: Product) {
        let controller = ProductDetailController(product: product)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchAllProductsSuccessful() {
        homeView.pageControl.numberOfPages = productsViewModel.products.count
        homeView.specialCollection.reloadData()
        homeView.productCollection.reloadData()
    }
    
    func didFetchAllCategories() {
        homeView.categoryCollection.reloadData()
    }
    
    func didFetchProductsByCategorySuccessful() {
        homeView.productCollection.reloadData()
    }
    
    

    
    func didUpdateWishListSuccessful() {
        productsViewModel.fetchWishList()
    }

}

//MARK: - ProductCollectionCellInterface

extension HomeController: ProductCollectionCellInterface {
    func productCollectionCell(_ view: ProductCollectionCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton) {
        productsViewModel.updateWishList(productId: productId, quantity: quantity)
    }
    
}
