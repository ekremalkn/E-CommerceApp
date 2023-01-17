//
//  SeperatorView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 17.01.2023.
//

import UIKit

class SeperatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        set(backgroundColor: backgroundColor)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
    
    

}
