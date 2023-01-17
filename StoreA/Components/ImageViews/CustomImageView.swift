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
    
    convenience init(image: UIImage, tintColor: UIColor, backgroundColor: UIColor, contentMode: ContentMode, cornerRadius: CGFloat, isUserInteractionEnabled: Bool) {
        self.init(frame: .zero)
        set(image: image, tintColor: tintColor, backgroundColor: backgroundColor, contentMode: contentMode, cornerRadius: cornerRadius, isUserInteractionEnabled: isUserInteractionEnabled)
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(image: UIImage, tintColor: UIColor, backgroundColor: UIColor, contentMode: ContentMode, cornerRadius: CGFloat, isUserInteractionEnabled: Bool) {
        self.image = image
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.isUserInteractionEnabled = isUserInteractionEnabled
    }
}
