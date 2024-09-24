//
//  File.swift
//  
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation

public struct URLQueryItemBuilder {
    
    private(set) var queryItems: [URLQueryItem]? = nil
    
    public mutating func add(name: String, value: String) {
        let queryItem = URLQueryItem(name: name, value: value)
        if queryItems != nil {
            queryItems?.append(queryItem)
        } else {
            queryItems = [queryItem]
        }
    }
    
    public func jsonString(from dictionary: [String: Any]) -> String {
        if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []),
           let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        }
        return ""
    }
    
    public func buildQueryURL(baseURL: String, path: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
