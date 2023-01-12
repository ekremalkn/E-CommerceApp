//
//  Double+Rounded.swift
//  StoreA
//
//  Created by Ekrem Alkan on 12.01.2023.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
            let divisor = pow(10.0, Double(places))
            return (self * divisor).rounded() / divisor
        }
}
