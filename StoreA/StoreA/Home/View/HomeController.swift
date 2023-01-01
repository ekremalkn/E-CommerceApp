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


    //MARK: - ViewDidLoad Method

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        homeViewModel.delegate = self
        homeViewModel.fetchAllProducts()

    }
    
}

//MARK: - HomeViewModelDelegate

extension HomeController: HomeViewModelDelegate {
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchProductsSuccesful() {
        print("\(homeViewModel.allProducts)ekrem")
    }
    
    
}
