//
//  OnboardingCollectionView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

final class OnboardingCollectionView: UICollectionView {
    
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(scrollIndicator: Bool, paging: Bool, layout: UICollectionViewFlowLayout) {
        self.init(frame: .zero, collectionViewLayout: layout )
        layout.scrollDirection = .horizontal
        set(scrollIndicator: scrollIndicator, paging: paging)
        
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(scrollIndicator: Bool, paging: Bool) {
        showsHorizontalScrollIndicator = scrollIndicator
        isPagingEnabled = paging
    }
}
