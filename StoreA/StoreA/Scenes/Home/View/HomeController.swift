//
//  HomeController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import UIKit

final class HomeController: UIViewController {
    
    //MARK: - Properties
    private let homeProfileViewModel = HomeProfileViewModel()
    private let productsViewModel = ProductsViewModel()
    private let homeView = HomeView()
    
    //MARK: -  Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        homeProfileViewModel.fetchUser()
        homeProfileViewModel.fetchProfilePhoto()
        homeProfileViewModel.getTime()
        productsViewModel.fetchCart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavBar()
        collectionCellRegister()
        setupDelegates()
        productsViewModel.fetchSpecialProducts()
        productsViewModel.fetchAllProducts()
        productsViewModel.fetchOnlyCategory()
    }
    
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        self.navigationController?.tabBarController?.tabBar.backgroundColor = .white
        view = homeView
    }
    
    
    private func configureNavBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    //MARK: - Register Custom Cell
    
    private func collectionCellRegister() {
        homeView.specialCollection.register(SpecialCollectionCell.self, forCellWithReuseIdentifier: SpecialCollectionCell.identifier)
        homeView.categoryCollection.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.identifier)
        homeView.productCollection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        homeProfileViewModel.delegate = self
        
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
            return productsViewModel.specialProducts.count
        case homeView.categoryCollection:
            return productsViewModel.allCategories.count
        case homeView.productCollection:
            return productsViewModel.productsByCategory.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case homeView.specialCollection:
            guard let cell = homeView.specialCollection.dequeueReusableCell(withReuseIdentifier: SpecialCollectionCell.identifier, for: indexPath) as? SpecialCollectionCell else { return UICollectionViewCell() }
            cell.configure(data: productsViewModel.specialProducts[indexPath.row])
            return cell
        case homeView.categoryCollection:
            guard let cell = homeView.categoryCollection.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as? CategoryCollectionCell else { return UICollectionViewCell()}
            cell.configure(data: productsViewModel.allCategories, indexPath: indexPath)
            return cell
        case homeView.productCollection:
            guard let cell = homeView.productCollection.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else { return UICollectionViewCell()}
            cell.interface = self
            cell.configure(data: productsViewModel.productsByCategory[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // This only selects the first cell
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case homeView.specialCollection:
            guard let productId = productsViewModel.specialProducts[indexPath.row].id else { return }
            productsViewModel.fetchSingleProduct(productId: productId)
        case homeView.categoryCollection:
            let category = productsViewModel.allCategories[indexPath.row]
            if category == "All" {
                productsViewModel.fetchAllProducts()
            } else {
                productsViewModel.fetchProductByCategory(category)
            }
        case homeView.productCollection:
            guard let productId = productsViewModel.productsByCategory[indexPath.row].id else { return }
            productsViewModel.fetchSingleProduct(productId: productId)
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case homeView.specialCollection:
            return CGSize(width: homeView.specialCollection.frame.width - 10, height:homeView.specialCollection.frame.height)
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
    func didFetchSpecialProductsSuccessful() {
        homeView.pageControl.numberOfPages = productsViewModel.specialProducts.count
        homeView.specialCollection.reloadData()
    }
    
    func didFetchAllProductsSuccessful() {
        homeView.productCollection.reloadData()
    }
    
    func didFetchAllCategories() {
        homeView.categoryCollection.reloadData()
    }
    
    func didFetchProductsByCategorySuccessful() {
        homeView.productCollection.reloadData()
    }
    
    func didUpdateWishListSuccessful() {
    }
   
    func didFetchCartCountSuccessful() {
        if let cartCount = productsViewModel.cart?.count {
            if cartCount == 0 {
                tabBarController?.tabBar.items?[2].badgeValue = nil
            } else {
                tabBarController?.tabBar.items?[2].badgeValue = "\(cartCount)"
            }
        }
        
    }
    
    
    
}

//MARK: - ProductCollectionCellInterface

extension HomeController: ProductCollectionCellInterface {
    func productCollectionCell(_ view: ProductCollectionCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton) {
        productsViewModel.updateWishList(productId: productId, quantity: quantity)
        
    }
    
}


extension HomeController: HomeProfileViewModelDelegate {
    
    func didGotCurrentTime() {
        homeView.hiLabel.text = homeProfileViewModel.hiText
    }
    
    func didFetchUserInfro() {
        homeView.usernameLabel.text = homeProfileViewModel.username
    }
    
    func didFetchProfilePhotoSuccessful(_ url: String) {
        homeView.profilePhotoImage.downloadSetImage(url: url)
    }
    
    
    
}

