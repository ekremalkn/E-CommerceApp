//
//  FilterViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 15.01.2023.
//

import Foundation

protocol FilterViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchAllCategoriesSuccessful()
}

final class FilterViewModel {
    
    //MARK: - FilterViewModelDelegate
    
    weak var delegate: FilterViewModelDelegate?
    
    //MARK: - Properties
    
    let manager = Service.shared
    
    //MARK: - Products
    
    var products: [Product] = []
    var allCategories = Categories()
    
    func fetchAllCategories() {
        manager.fetchCategory { categories in
            if let categories = categories {
                self.allCategories = categories
                self.allCategories.insert("All", at:0)
                self.delegate?.didFetchAllCategoriesSuccessful()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
    }
    
}
