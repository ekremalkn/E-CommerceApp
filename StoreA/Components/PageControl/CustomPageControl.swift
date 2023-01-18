//
//  CustomPageControl.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

final class CustomPageControl: UIPageControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        currentPageIndicatorTintColor = .black
        pageIndicatorTintColor = .systemGray
    }
}
