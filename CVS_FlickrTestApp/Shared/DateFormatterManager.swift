//
//  DateFormatterManager.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/24/24.
//

import Foundation

public class DateFormatterManager {
    
    public static let shared = DateFormatterManager()
    private init() {}
    
    public func dateFromString(_ string: String, format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue

        return dateFormatter.date(from: string)
    }
    
    public enum DateFormat: String {
        case sql = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
}
