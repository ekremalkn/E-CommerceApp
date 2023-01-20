//
//  CustomImageView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 17.01.2023.
//

import UIKit

class CustomImageView: UIImageView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage? = nil, tintColor: UIColor? = nil, backgroundColor: UIColor? = nil, contentMode: ContentMode, maskedToBounds: Bool? = nil, cornerRadius: CGFloat? = nil, isUserInteractionEnabled: Bool? = nil) {
        self.init(frame: .zero)
        set(image: image, tintColor: tintColor, backgroundColor: backgroundColor, contentMode: contentMode, maskedToBounds: maskedToBounds, cornerRadius: cornerRadius, isUserInteractionEnabled: isUserInteractionEnabled)
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(image: UIImage? = nil, tintColor: UIColor? = nil, backgroundColor: UIColor? = nil, contentMode: ContentMode, maskedToBounds: Bool? = nil ,cornerRadius: CGFloat? = nil, isUserInteractionEnabled: Bool? = nil) {
        self.contentMode = contentMode
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        if let image = image {
            self.image = image
        }
        if let maskedToBounds = maskedToBounds {
            layer.masksToBounds = maskedToBounds
        }
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let isUserInteractionEnabled = isUserInteractionEnabled {
            self.isUserInteractionEnabled = isUserInteractionEnabled
        }

    }
}
