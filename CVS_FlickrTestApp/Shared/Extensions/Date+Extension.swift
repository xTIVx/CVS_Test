//
//  Date+Extension.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/24/24.
//

import Foundation

extension Date {
    func format(to format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    enum DateFormat: String {
        /// "Sep 23, 9:29pm"
        case standard = "MMM d, h:mma"
    }
}
