//
//  UIView+AddSubview.swift
//  StoreA
//
//  Created by Ekrem Alkan on 18.01.2023.
//

import UIKit

//MARK: - for addsubview

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
