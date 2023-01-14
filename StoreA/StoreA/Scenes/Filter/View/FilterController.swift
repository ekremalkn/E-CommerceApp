//
//  FilterController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit


final class FilterController: UIViewController {
    
    deinit {
        print("deinit FilterController")
    }

    private var topAnchorValue: CGFloat?
    //MARK: - Properties
    
    private let searchViewModel = SearchViewModel()
    private let filterViewModel = FilterViewModel()
    private let filterView = FilterView()


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
        title = "Categories"
        navigationController?.setNavigationBarHidden(false, animated: true)
        view = filterView
    }
    
    //MARK: - Register Custom Cell
    
    private func registerCustomCell() {
        filterView.filterTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
    }

    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        filterViewModel.delegate = self
        
        filterView.filterTableView.delegate = self
        filterView.filterTableView.dataSource = self
    }

}

extension FilterController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterViewModel.allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = filterView.filterTableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        cell.categoryTitleLabel.text = filterViewModel.allCategories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            if let category = self?.filterViewModel.allCategories[indexPath.row] {
                self?.searchViewModel.fetchProductByCagetory(category)

            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

extension FilterController: FilterViewModelDelegate {
    func didOccurError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchAllCategories() {
        filterView.filterTableView.reloadData()
    }
    
 
    
    
}


