//
//  File.swift
//  
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation

public struct Configuration: HTTPRequestProtocol {
    public let path: String
    public let httpHeaders: [String : String?]
    public let httpMethod: HTTP.Method
    public let queryParameters: [QueryParameter]?
    public let httpBody: Data?
    
    public init(headers: [String: String?], settings: HTTPRequestProtocol) {
        self.path = settings.path
        self.httpHeaders = headers
        self.httpMethod = settings.httpMethod
        self.queryParameters = settings.queryParameters
        self.httpBody = settings.httpBody
    }
}
