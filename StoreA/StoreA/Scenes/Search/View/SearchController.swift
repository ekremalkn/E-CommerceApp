//
//  SearchController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import UIKit

final class SearchController: UIViewController {
    
    //MARK: - Properties
    private let productsViewModel = ProductsViewModel()
    private let searchViewModel = SearchViewModel()
    private let searchView = SearchView()
    
    //MARK: - SearchController/SearchBar
    
    private weak var searchController: UISearchController? {
        return searchView.searchController
    }
    
    private weak var searchBar: UISearchBar? {
        return searchView.searchController.searchBar
    }
    
    var isSearchBarEmpty: Bool {
        return searchBar?.text?.isEmpty ?? true
    }
    
    //MARK: - Products
    
    var filteredProducts: [Product] = []
    
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavBar()
        collectionCellRegister()
        setupDelegates()
        searchViewModel.fetchAllProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        view = searchView
        navigationController?.tabBarController?.tabBar.backgroundColor = .white
        navigationItem.searchController = searchController
    }
    
    
    private func configureNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    //MARK: - FilterForSearchText
    
    private func filterForSearchText(_ searchText: String) {
        if isSearchBarEmpty {
            searchView.searchResultLabelsStackView.isHidden = true
        } else {
            filteredProducts = searchViewModel.products.filter { Product in
                Product.title!.lowercased().contains(searchText.lowercased())
            }
            searchView.searchResultLabelsStackView.isHidden = false
            searchView.configure(searchText: searchText, count: filteredProducts.count)
            
        }
        searchView.searchCollection.reloadData()
    }
    
    //MARK: - Register Custom Cell
    
    private func collectionCellRegister() {
        searchView.searchCollection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: ProductCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        searchViewModel.delegate = self
        
        searchBar?.delegate = self
        searchController?.searchResultsUpdater = self
        
        searchView.searchCollection.delegate = self
        searchView.searchCollection.dataSource = self
    }
    
}

//MARK: - SearchBar Methods

extension SearchController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchBar?.text else { return }
        filterForSearchText(searchText)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let filterVC = FilterController()
        filterVC.modalPresentationStyle = .custom
        filterVC.transitioningDelegate = self
        filterVC.selectionCallBack = { category in
            if category == "All" {
                self.searchViewModel.fetchAllProducts()
            } else {
                self.searchViewModel.fetchProductByCagetory(category)
            }
        }
        self.present(filterVC, animated: true, completion: nil)
        
        
    }
    
}

//MARK: - CollectionViewMethods

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchBarEmpty {
            return searchViewModel.products.count
        } else {
            return filteredProducts.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchView.searchCollection.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.identifier, for: indexPath) as? ProductCollectionCell else { return UICollectionViewCell()}
        cell.interface = self
        if isSearchBarEmpty {
            cell.configure(data: searchViewModel.products[indexPath.row])
            return cell
        } else {
            cell.configure(data: filteredProducts[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let productId = searchViewModel.products[indexPath.row].id else { return }
        searchViewModel.fetchSingleProduct(productId: productId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: searchView.searchCollection.frame.width / 2 - 10, height: searchView.searchCollection.frame.height / 3 )
        
    }
}

//MARK: - SearchViewModelDelegate

extension SearchController: SearchViewModelDelegate {
    
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchSingleProduct(_ product: Product) {
        let controller = ProductDetailController(product: product)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didFetchSearchProductsSuccessful() {
        searchView.searchCollection.reloadData()
    }
    
    func didFetchProductsByCategorySuccessful() {
        searchView.searchCollection.reloadData()
    }
    
}


//MARK: - ProductCollectionCellInterface

extension SearchController: ProductCollectionCellInterface {
    func productCollectionCell(_ view: ProductCollectionCell, productId: Int, quantity: Int, wishButtonTapped button: UIButton) {
        productsViewModel.updateWishList(productId: productId, quantity: quantity)
    }
}

//MARK: - CustomPresentationController

extension SearchController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}


