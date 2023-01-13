//
//  WishListView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 13.01.2023.
//

import UIKit

final class WishListView: UIView {

    deinit {
        print("deinit wishlistview")
    }
    
    //MARK: - Creating UI Elements

    let wishListCollection: UICollectionView = {
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
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}

extension WishListView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubview(wishListCollection)
    }
    
    //MARK: - SetupConstraints
    
    private func setupConstraints() {
        wishListCollectionConstraints()
    }

    
    //MARK: - UI Elements Constraints
    
    private func wishListCollectionConstraints() {
        wishListCollection.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }


}
