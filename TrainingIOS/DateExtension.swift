//
//  DateExtension.swift
//  TrainingIOS
//
//  Created by DaoNhat on 8/22/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import Foundation
extension Date {
    
    // MARK: - Date
    static func convertDateToString(fromDate: Date?, format: String) -> String? {
        if let convertDate = fromDate {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone.default
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: convertDate)
        } else {
            return nil
        }
    }
    
    static func convertStringToDate(fromString: String?, format: String) -> Date? {
        if let dateString = fromString {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone.default
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = format
            return dateFormatter.date(from: dateString)
        } else {
            return nil
        }
    }
    
    static func convertStringDateToString(fromString: String?, fromFormat: String, toFormat: String) -> String? {
        if let dateString = fromString {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone.default
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = fromFormat
            guard let date = dateFormatter.date(from: dateString) else {
                return nil
            }
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
}
