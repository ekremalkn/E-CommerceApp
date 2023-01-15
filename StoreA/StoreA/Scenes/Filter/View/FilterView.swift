//
//  FilterView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit

final class FilterView: UIView {
    
    deinit {
        print("deinit FilterView")
    }
    
    //MARK: - Creating UI Elements
    
    private let customGrabber: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let filterTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Sort & Filter"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionTitlLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Categories"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var filterCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubview(filterTitleLabel)
        addSubview(seperatorView)
        addSubview(collectionTitlLabel)
        addSubview(customGrabber)
        addSubview(filterCollection)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        grabberConstraints()
        filterTitleLabelConstraints()
        seperatorViewConstraints()
        collectionTitleConstraints()
        filterCollectionConstraints()
        
    }
    
    //MARK: - UI Elements Constraints
    
    private func grabberConstraints() {
        customGrabber.snp.makeConstraints { make in
            customGrabber.layer.cornerRadius = 5
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
            make.height.equalTo(customGrabber.snp.width).multipliedBy(0.05)
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func filterTitleLabelConstraints() {
        filterTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(customGrabber.snp.bottom).offset(20)
            make.centerX.equalTo(customGrabber.snp.centerX)
        }
    }
    
    private func seperatorViewConstraints() {
        seperatorView.snp.makeConstraints { make in
            make.height.equalTo(0.75)
            make.top.equalTo(filterTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(filterCollection.snp.leading)
            make.trailing.equalTo(filterCollection.snp.trailing)
        }
    }
    
    private func collectionTitleConstraints() {
        collectionTitlLabel.snp.makeConstraints { make in
            make.height.equalTo(collectionTitlLabel.snp.height)
            make.top.equalTo(seperatorView.snp.bottom).offset(20)
            make.leading.equalTo(filterCollection.snp.leading)
        }
    }
    
    
    private func filterCollectionConstraints() {
        filterCollection.snp.makeConstraints { make in
            make.top.equalTo(collectionTitlLabel.snp.bottom).offset(15)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
