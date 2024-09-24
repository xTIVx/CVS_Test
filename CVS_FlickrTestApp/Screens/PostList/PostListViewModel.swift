//
//  PostListViewModel.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation
import Combine

final class PostListViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private let flickrService: FlickrWebServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var searchCancellable: AnyCancellable?
    
    init(flickrService: FlickrWebServiceProtocol) {
        self.flickrService = flickrService
        updateSearch()
    }
    
    func getPosts(with query: String) -> AnyPublisher<[Post], NetworkingError> {
        return flickrService.fetchPosts(with: query)
    }
    
    func updateSearch() {
        searchCancellable = nil
        
        searchCancellable = $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [weak self] in
                self?.startLoading()
                return $0
            }
            .flatMap { [weak self] newSearchText -> AnyPublisher<[Post], NetworkingError> in
                guard let self = self else { return Just([]).setFailureType(to: NetworkingError.self).eraseToAnyPublisher() }
                if newSearchText.isEmpty {
                    return self.getPosts(with: "porcupine").compactMap({ $0 }).eraseToAnyPublisher()
                } else {
                    return self.getPosts(with: newSearchText).compactMap({ $0 }).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { status in
                if case let .failure(networkingError) = status {
                    print(networkingError.descriptionText)
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
                self?.isLoading = false
            })
    }
    
    private func startLoading() {
        isLoading = true
        posts.removeAll()
    }
}
