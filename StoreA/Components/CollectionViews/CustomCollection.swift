//
//  CustomCollection.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

final class CustomCollection: UICollectionView {
    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil, showsScrollIndicator: Bool? = nil, paging: Bool? = nil, layout: UICollectionViewFlowLayout, scrollDirection: UICollectionView.ScrollDirection? = nil, estimatedItemSize: CGSize? = nil, minimumInteritemSpacing: CGFloat? = nil, minimumLineSpacing: CGFloat? = nil ) {
        self.init(frame: .zero, collectionViewLayout: layout )
        if let scrollDirection = scrollDirection {
            layout.scrollDirection = scrollDirection
        }
        if let estimatedItemSize = estimatedItemSize {
            layout.estimatedItemSize = estimatedItemSize
        }
        if let minimumInteritemSpacing = minimumInteritemSpacing {
            layout.minimumInteritemSpacing = minimumInteritemSpacing
        }
        if let minimumLineSpacing = minimumLineSpacing {
            layout.minimumLineSpacing = minimumLineSpacing
        }
        
        set(backgroundColor: backgroundColor, cornerRadius: cornerRadius, showsScrollIndicator: showsScrollIndicator, paging: paging)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil, showsScrollIndicator: Bool? = nil, paging: Bool? = nil) {
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let showsScrollIndicator = showsScrollIndicator {
            showsVerticalScrollIndicator = showsScrollIndicator
            showsHorizontalScrollIndicator = showsScrollIndicator
        }
        if let paging = paging {
            isPagingEnabled = paging
        }
    }
}
