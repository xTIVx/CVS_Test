//
//  File.swift
//  
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation

public struct QueryParameter {
    
    let key: String
    let value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
