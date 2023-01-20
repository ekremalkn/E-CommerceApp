//
//  FilterController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit


final class FilterController: UIViewController {
   
    //MARK: - Properties
    
    private let searchViewModel = SearchViewModel()
    private let filterViewModel = FilterViewModel()
    private let filterView = FilterView()
    
    var selectionCallBack: ((String) -> ())?
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterViewModel.fetchAllCategories()
        configureViewController()
        registerCustomCell()
        setupDelegates()
    }
    
    
    //MARK: - ConfigureViewController
    
    private func configureViewController() {
        view = filterView
    }
    
    //MARK: - Register Custom Cell
    
    private func registerCustomCell() {
        filterView.filterCollection.register(FilterCollectionCell.self, forCellWithReuseIdentifier: FilterCollectionCell.identifier)
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        filterViewModel.delegate = self
        
        
        filterView.filterCollection.delegate = self
        filterView.filterCollection.dataSource = self
        
    }
    
}

extension FilterController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterViewModel.allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = filterView.filterCollection.dequeueReusableCell(withReuseIdentifier: FilterCollectionCell.identifier, for: indexPath) as? FilterCollectionCell else { return UICollectionViewCell() }
        cell.configure(data: filterViewModel.allCategories, indexPath: indexPath)
        return cell
    }
    
    // This only selects the first cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        filterView.filterCollection.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = filterViewModel.allCategories[indexPath.row]
        dismiss(animated: true) {
            self.selectionCallBack?(category)
        }
    }
    
}

//MARK: - FilterViewModelDelegate

extension FilterController: FilterViewModelDelegate {
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchAllCategoriesSuccessful() {
        filterView.filterCollection.reloadData()
    }
    
    
}



