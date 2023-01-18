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
    
    convenience init(backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil,axis: NSLayoutConstraint.Axis? = nil, distiribution: UIStackView.Distribution? = nil, spacing: CGFloat? = nil, isHidden: Bool? = nil) {
        self.init(frame: .zero)
       set(backgroundColor: backgroundColor, cornerRadius: cornerRadius, axis: axis, distiribution: distiribution, spacing: spacing, isHidden: isHidden)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil,axis: NSLayoutConstraint.Axis? = nil, distiribution: UIStackView.Distribution? = nil, spacing: CGFloat? = nil, isHidden: Bool? = nil) {
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let axis = axis {
            self.axis = axis
        }
        if let distiribution = distiribution {
            self.distribution = distiribution
        }
        if let spacing = spacing {
            self.spacing = spacing
        }
        if let isHidden = isHidden {
            self.isHidden = isHidden
        }
      
    }
    
}
