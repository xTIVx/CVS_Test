//
//  File.swift
//  
//
//  Created by Igor Chernobai on 9/23/24.
//

import Combine
import Foundation

public final class NetworkManager: ObservableObject {
    private let session: URLSession = URLSession.shared
    private let baseURL: String
    
    //MARK: - Initializer
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    //MARK: - Methods
    
    public func request<T: Decodable>(with httpRequest: HTTPRequestProtocol) -> AnyPublisher<T, NetworkingError> {
        guard let urlRequest = buildURLRequest(from: httpRequest) else {
            return Fail(error: NetworkingError.badURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap(handleResponse)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError(NetworkManager.mapError)
            .eraseToAnyPublisher()
    }
    
    public func request(with httpRequest: HTTPRequestProtocol) -> AnyPublisher<Void, NetworkingError> {
        guard let urlRequest = buildURLRequest(from: httpRequest) else {
            return Fail(error: NetworkingError.badURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap(handleVoidResponse)
            .mapError(NetworkManager.mapError)
            .eraseToAnyPublisher()
    }
    
    //MARK: - URL Helpers
    private func buildURLRequest(from httpRequest: HTTPRequestProtocol) -> URLRequest? {
        guard let url = buildURL(from: httpRequest) else {
            return nil
        }
        let httpHeaders = httpRequest.httpHeaders
        let httpMethod = httpRequest.httpMethod
        let httpBody = httpMethod != .get ? httpRequest.httpBody : nil
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = httpBody
        
        for (key, value) in httpHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    private func buildURL(from request: HTTPRequestProtocol) -> URL? {
        var queryBuilder = URLQueryItemBuilder()
        if let queryParams = request.queryParameters {
            queryParams.forEach { queryBuilder.add(name: $0.key, value: $0.value) }
        }
        return queryBuilder.buildQueryURL(baseURL: baseURL, path: request.path)
    }
    
    //MARK: - Helpers
    private func handleResponse(_ data: Data, _ response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              case 200..<300 = httpResponse.statusCode else {
            throw NetworkingError.unknownError(.errorData(data))
        }
        return data
    }
    
    private func handleVoidResponse(_ data: Data, _ response: URLResponse) throws -> Void {
        guard let httpResponse = response as? HTTPURLResponse,
              case 200..<300 = httpResponse.statusCode else {
            throw NetworkingError.unknownError(.errorData(data))
        }
        return Void()
    }
    
    public static func mapError(_ error: Error) -> NetworkingError {
        switch error {
        case is URLError:
            return NetworkingError.networkError(error)
        case let decodingError as DecodingError:
            let decodingErrorInfo = processDecodingError(decodingError)
            return NetworkingError.decodingError(decodingErrorInfo)
        case let networkingError as NetworkingError:
            return networkingError
        default:
            return NetworkingError.unknownError(.error(error))
        }
    }
    
    private static func processDecodingError(_ decodingError: DecodingError) -> String {
        let decodingErrorDescription: String
        switch decodingError {
        case .dataCorrupted(let context):
            return "Data corrupted: \(context.debugDescription)"
        case .keyNotFound(let key, let context):
            return "Key not found: \(key.stringValue), \(context.debugDescription), \(context.codingPath)"
        case .typeMismatch(let type, let context):
            return "Type mismatch: \(type), \(context.debugDescription), \(context.codingPath)"
        case .valueNotFound(let type, let context):
            return "Value not found: \(type), \(context.debugDescription), \(context.codingPath)"
        @unknown default:
            decodingErrorDescription = "Unknown decoding error"
        }
        return decodingErrorDescription
    }
}

public protocol HTTPRequestProtocol {
    var path: String { get }
    var httpHeaders: [String: String?] { get }
    var httpMethod: HTTP.Method { get }
    var queryParameters: [QueryParameter]? { get }
    var httpBody: Data? { get }
}

public extension HTTPRequestProtocol {
    var httpBody: Data? {
        return nil
    }
    
    var queryParameters: [QueryParameter]? {
        return nil
    }
}

public struct CustomRequest: HTTPRequestProtocol {
    public var path: String
    public var httpHeaders: [String : String?]
    public var httpMethod: HTTP.Method
    public var httpBody: Data?
    
    public init(path: String, httpHeaders: [String : String?], httpMethod: HTTP.Method, httpBody: Data? = nil) {
        self.path = path
        self.httpHeaders = httpHeaders
        self.httpMethod = httpMethod
        self.httpBody = httpBody
    }
}

public enum HTTP {
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    public enum HeaderName {
        public static let contentType = "Content-Type"
    }
    
    public enum HeaderValue {
        public static let applicationJSON = "application/json"
    }
}
