//
//  SearchView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    
    var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil )
        searchController.searchBar.searchTextField.placeholder = "Search Products"
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchController
    }()
    
    private var searchResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Results for SearchTextField"
        label.numberOfLines  = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var searchResultCountLabel: UILabel = {
        let label = UILabel()
        label.text =  "12313 founds"
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var searchResultLabelsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.isHidden = true
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    var searchCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray6
        collection.showsVerticalScrollIndicator = false
        collection.isPagingEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        configureSearchBar()
        addSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(searchText: String, count: Int) {
        searchResultsLabel.text = "Results for '\(searchText)'"
        searchResultCountLabel.text = "\(count) founds"
    }
    
    //MARK: - Configure SearchBar
    
    private func configureSearchBar() {
        searchController.searchBar.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)
    }
    
    //MARK: - AddSearchResultLabelsToStackView
    
    private func addSearchResultLabelsToStackView() {
        searchResultLabelsStackView.addArrangedSubview(searchResultsLabel)
        searchResultLabelsStackView.addArrangedSubview(searchResultCountLabel)
    }
    
}

extension SearchView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubview(searchController.searchBar)
        addSubview(searchResultsLabel)
        addSubview(searchResultCountLabel)
        addSearchResultLabelsToStackView()
        addSubview(searchResultLabelsStackView)
        addSubview(searchCollection)
    }
    
    //MARK: - SetupConstraints
    
    private func setupConstraint() {
        searchBarConstraint()
        searchLabelStackViewConstraints()
        searchCollectionConsraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func searchBarConstraint() {
        searchController.searchBar.snp.makeConstraints { make in
          
        }
    }
    
    private func searchLabelStackViewConstraints()  {
        searchResultLabelsStackView.snp.makeConstraints { make in
            make.height.equalTo(searchResultCountLabel.snp.height)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func searchCollectionConsraints() {
        searchCollection.snp.makeConstraints { make in
            make.top.equalTo(searchResultLabelsStackView.snp.bottom).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    
    
    
}
