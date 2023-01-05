//
//  SearchController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import UIKit

final class SearchController: UIViewController {

    //MARK: - Properties
    private let searchViewModel = SearchViewModel()
    private let searchView = SearchView()
    
    var filteredProducts: [Product] = []
    
    var isSearchBarEmpty: Bool {
        return searchView.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
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
    }
    
    //MARK: - FilterForSearchText
    
    private func filterForSearchText(_ searchText: String) {
            if isSearchBarEmpty {
                searchViewModel.allProducts = filteredProducts
                searchView.searchCollection.reloadData()
            } else {
                filteredProducts = searchViewModel.allProducts.filter { Product in
                    Product.title!.lowercased().contains(searchText.lowercased())
                }
                searchView.searchResultLabelsStackView.isHidden = false
                searchView.configure(searchText: searchText, count: filteredProducts.count)
                searchView.searchCollection.reloadData()
            }
            
        
    }

    
    //MARK: - Register Custom Cell

    private func collectionCellRegister() {
        searchView.searchCollection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        searchViewModel.delegate = self
        
        searchView.searchBar.delegate = self
        
        searchView.searchCollection.delegate = self
        searchView.searchCollection.dataSource = self
    }
    

    
}

//MARK: - SearchBar Methods

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterForSearchText(searchText)
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("category filter")
    }
    

}

//MARK: - CollectionViewMethods

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchView.searchCollection.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        cell.configure(data: filteredProducts[indexPath.row])
        return cell
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
    
    func didFetchFilteredItemsSuccessful() {
        searchView.searchCollection.reloadData()
        filteredProducts = searchViewModel.allProducts
    }
    
    
}


