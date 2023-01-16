//
//  OnboardingButton.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

final class OnboardingButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, titleColor: UIColor, font: UIFont, backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        set(title: title, titleColor: titleColor, font: font, backgroundColor: backgroundColor, cornerRadius: cornerRadius)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(title: String, titleColor: UIColor, font: UIFont, backgroundColor: UIColor, cornerRadius: CGFloat) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        layer.cornerRadius = cornerRadius
    }
    
}
