//
//  CustomTextField.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(isSecureTextEntry: Bool? = nil ,attributedPlaceholder: NSAttributedString, image: UIImage) {
        self.init(frame: .zero)
        set(isSecureTextEntry: isSecureTextEntry ,attributedPlaceholder: attributedPlaceholder, image: image)
    }
    
    private func configure() {
        autocapitalizationType = .none
        textColor = .black
        backgroundColor = .white
        leftViewMode = .always
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func set(isSecureTextEntry: Bool? = nil ,attributedPlaceholder: NSAttributedString, image: UIImage) {
        self.attributedPlaceholder = attributedPlaceholder
        let imageView = UIImageView()
        let image = image
        imageView.image = image
        imageView.tintColor = .systemGray
        leftView = imageView
        if let isSecureTextEntry = isSecureTextEntry {
            self.isSecureTextEntry = isSecureTextEntry
        }
        
    }
    
}
