//
//  CustomStackView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

class CustomStackView: UIStackView {

 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(axis: NSLayoutConstraint.Axis, distiribution: UIStackView.Distribution, spacing: CGFloat, isHidden: Bool) {
        self.init(frame: .zero)
        set(axis: axis, distiribution: distiribution, spacing: spacing, isHidden: isHidden)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(axis: NSLayoutConstraint.Axis, distiribution: UIStackView.Distribution, spacing: CGFloat, isHidden: Bool) {
        self.axis = axis
        self.distribution = distiribution
        self.spacing = spacing
        self.isHidden = isHidden
    }
    
}
