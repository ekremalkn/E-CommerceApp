//
//  FilterViewModel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import Foundation

protocol FilterViewModelDelegate: AnyObject {
    func didOccurError(_ error: Error)
    func didFetchAllCategories()
}

final class FilterViewModel {
    
    deinit {
        print("deinit FilterViewModel")
    }
    
    weak var delegate: FilterViewModelDelegate?
    let manager = Service.shared
    
    var allCategories = Categories()
    var productsByCategory: [Product] = []
    
    func fetchAllCategories() {
        manager.fetchCategory { categories in
            if let categories = categories {
                self.allCategories = categories
                self.delegate?.didFetchAllCategories()
            }
        } onError: { error in
            self.delegate?.didOccurError(error)
        }
    }
}
