//
//  CustomButton.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String? = nil, titleColor: UIColor? = nil, font: UIFont? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil, image: UIImage? = nil, contentHorizontalAlignment: UIControl.ContentHorizontalAlignment? = nil , contentVerticalAignment: UIControl.ContentVerticalAlignment? = nil, tintColor: UIColor? = nil, imageEdgeInsets: UIEdgeInsets? = nil, titleEdgeInsets: UIEdgeInsets? = nil) {
        self.init(frame: .zero)
        set(title: title, titleColor: titleColor, font: font, backgroundColor: backgroundColor, cornerRadius: cornerRadius, image: image, tintColor: tintColor, imageEdgeInsets: imageEdgeInsets, titleEdgeInsets: titleEdgeInsets)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(title: String? = nil, titleColor: UIColor? = nil, font: UIFont? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat? = nil, image: UIImage? = nil, tintColor: UIColor? = nil, imageEdgeInsets: UIEdgeInsets? = nil, titleEdgeInsets: UIEdgeInsets? = nil) {
        if let title = title {
            setTitle(title, for: .normal)
        }
        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal)
        }
        if let font = font {
            titleLabel?.font = font
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let image = image {
            setImage(image, for: .normal)
        }
        if let imageEdgeInsets = imageEdgeInsets {
            self.imageEdgeInsets = imageEdgeInsets
        }
        if let titleEdgeInsets = titleEdgeInsets {
            self.titleEdgeInsets = titleEdgeInsets
        }
        
    }
    
}
