//
//  CustomView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 17.01.2023.
//

import UIKit

class CustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        set(backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }

}
