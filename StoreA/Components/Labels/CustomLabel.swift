//
//  CustomLabel.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

class CustomLabel: UILabel {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, numberOfLines: Int, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment, isHidden: Bool? = nil) {
        self.init(frame: .zero)
        set(text: text, numberOfLines: numberOfLines, font: font, textColor: textColor, textAlignment: textAlignment, isHidden: isHidden)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func set(text: String, numberOfLines: Int, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment, isHidden: Bool? = nil) {
        self.text = text
        self.numberOfLines = numberOfLines
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        if let isHidden = isHidden {
            self.isHidden = isHidden
        }
    }
    

}
