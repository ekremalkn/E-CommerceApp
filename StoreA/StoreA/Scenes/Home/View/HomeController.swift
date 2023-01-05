//
//  HomeController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import UIKit

final class HomeController: UIViewController {
    
    //MARK: - Properties
    private let homeViewModel = HomeViewModel()
    private let homeView = HomeView()
    
    //MARK: - ViewWillAppper Method

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - ViewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        collectionCellRegister()
        setupDelegates()
        homeViewModel.fetchAllProducts()
        homeViewModel.fetchOnlyCategory()
        

    }
    
    //MARK: - Register Custom CollectinCell
    
    private func collectionCellRegister() {
        homeView.specialCollection.register(SpecialCollectionCell.self, forCellWithReuseIdentifier: "SpecialCollectionCell")
        homeView.categoryCollection.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        homeView.productCollection.register(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
    }
    
    //MARK: - Setup Delegates
    private func setupDelegates() {
        homeViewModel.delegate = self
        
        homeView.searcBar.delegate = self
        
        homeView.specialCollection.delegate = self
        homeView.specialCollection.dataSource = self
        homeView.categoryCollection.delegate = self
        homeView.categoryCollection.dataSource = self
        homeView.productCollection.delegate = self
        homeView.productCollection.dataSource = self
    }
    
    
    //MARK: - Configure ViewController
    
    private func configureViewController() {
        view = homeView
    }
    

    
}


extension HomeController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
     
    }
    
}


//MARK: - CollectionViews Methods

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case homeView.specialCollection:
            return homeViewModel.allProducts.count
        case homeView.categoryCollection:
            return homeViewModel.allCategories.count
        case homeView.productCollection:
            return homeViewModel.allProducts.count
        default:
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case homeView.specialCollection:
            let cell = homeView.specialCollection.dequeueReusableCell(withReuseIdentifier: "SpecialCollectionCell", for: indexPath) as! SpecialCollectionCell
            cell.configure(data: homeViewModel.allProducts[indexPath.row])
            return cell
        case homeView.categoryCollection:
            let cell = homeView.categoryCollection.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
            cell.configure(data: homeViewModel.allCategories, indexPath: indexPath)
            return cell
        case homeView.productCollection:
            let cell = homeView.productCollection.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
            
            cell.configure(data: homeViewModel.allProducts[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case homeView.specialCollection:
            return CGSize(width: homeView.specialCollection.frame.width - 10, height:homeView.specialCollection.frame.height)
        case homeView.categoryCollection:
            return CGSize(width: homeView.categoryCollection.frame.width / 3, height: homeView.categoryCollection.frame.height / 1.25)
        case homeView.productCollection:
            return CGSize(width: homeView.productCollection.frame.width / 2 - 10, height: homeView.productCollection.frame.height )
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



//MARK: - HomeViewModelDelegate

extension HomeController: HomeViewModelDelegate {
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchItemsSuccesful() {
        homeView.pageControl.numberOfPages = homeViewModel.allProducts.count
        homeView.specialCollection.reloadData()
        homeView.productCollection.reloadData()
        homeView.categoryCollection.reloadData()
        
    }
    
    
}
