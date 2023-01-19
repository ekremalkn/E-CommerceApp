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
    
    private var customGrabber = CustomView(backgroundColor: .systemGray4, cornerRadius: 5)
    private var filterTitleLabel = CustomLabel(text: "Sort & Filter", numberOfLines: 0, font: .boldSystemFont(ofSize: 20), textColor: .black, textAlignment: .center)
    private var seperatorView = CustomView(backgroundColor: .systemGray5)
    private var collectionTitlLabel = CustomLabel(text: "Categories", numberOfLines: 0, font: .boldSystemFont(ofSize: 17), textColor: .black, textAlignment: .left)
    var filterCollection = CustomCollection(backgroundColor: .white, showsScrollIndicator: false, paging: false, layout: UICollectionViewFlowLayout(), scrollDirection: .vertical, estimatedItemSize: UICollectionViewFlowLayout.automaticSize, minimumInteritemSpacing: 5, minimumLineSpacing: 5)
    
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
        addSubviews(filterTitleLabel, seperatorView, collectionTitlLabel, customGrabber, filterCollection)
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
