//
//  UIStackView+AddArrangedSubview.swift
//  StoreA
//
//  Created by Ekrem Alkan on 18.01.2023.
//

import UIKit


extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
