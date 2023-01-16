//
//  HomeButton.swift
//  StoreA
//
//  Created by Ekrem Alkan on 16.01.2023.
//

import UIKit

class HomeButton: UIButton {

   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        set(image: image)
    }
    
    private func configure() {
        tintColor = .black
        layer.cornerRadius = 15
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func set(image: UIImage) {
        setImage(image, for: .normal)

        
    }
    
    
    
}
