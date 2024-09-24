//
//  FlickrWebService.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation
import Networking
import Combine

protocol FlickrWebServiceProtocol {
    func fetchPosts(with query: String) -> AnyPublisher<[Post], NetworkingError>
}

class FlickrWebService: FlickrWebServiceProtocol, ObservableObject {
    static let shared = FlickrWebService()
    private init() {}
        
    private let networkService = NetworkManager(baseURL: Configuration.Flickr.baseUrl.absoluteString)
    
    func fetchPosts(with query: String) -> AnyPublisher<[Post], NetworkingError> {
        let settings = Configuration.Flickr.Methods.getPost(query: query)
        return networkService
            .request(with: settings)
            .map { (container: PostDataContainer) -> [Post] in container.items }
            .eraseToAnyPublisher()
    }
}

class MockingFlickrWebService: FlickrWebServiceProtocol {
    func fetchPosts(with query: String) -> AnyPublisher<[Post], NetworkingError> {
        let porcupine = Post(
            title: query.isEmpty ? "Porcupine" : query,
            description: "description text",
            author: "me",
            publishDate: "Sep 23",
            imageUrl: ""
        )
        return Just([porcupine])
            .setFailureType(to: NetworkingError.self)
            .eraseToAnyPublisher()
    }
}
