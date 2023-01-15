//
//  NSDate+GetTimeDateFormat.swift
//  StoreA
//
//  Created by Ekrem Alkan on 15.01.2023.
//

import Foundation


extension NSDate
{
    func getCurrentHour() -> Int {
           let currentDateTime = Date()
        let calendar = NSCalendar.current
        let component = calendar.component(.hour, from: currentDateTime)
           let hour = component
           return hour
       }
    
}

