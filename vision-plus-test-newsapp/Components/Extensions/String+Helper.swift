//
//  String+Helper.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

enum DateFormat: String {
    case miliSeconds = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case humanTime = "d MMM yyyy"
    case dayWithName = "EEEE, d MMM yyyy"
}

extension String {
    
    func dateFormat(from: DateFormat, to: DateFormat) -> String {
        let formatFrom = DateFormatter()
        formatFrom.dateFormat = from.rawValue
        
        let formatTo = DateFormatter()
        formatTo.dateFormat = to.rawValue
        
        if let date = formatFrom.date(from: self) {
            let calendar = Calendar.current
            if calendar.component(.day, from: Date()) == calendar.component(.day, from: date) {
                return "Today"
            }
            
            return formatTo.string(from: date)
        }
        
        return self
    }
}
