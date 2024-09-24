//
//  CVS_FlickrTestAppTests.swift
//  CVS_FlickrTestAppTests
//
//  Created by Igor Chernobai on 9/23/24.
//

import Combine
import XCTest
@testable import CVS_FlickrTestApp

final class CVS_FlickrTestAppTests: XCTestCase {
    
    var sut: FlickrWebServiceProtocol?
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        sut = MockingFlickrWebService()
    }

    override func tearDownWithError() throws {
        sut = nil
        cancellables.removeAll()
    }

    func test_fetchPostsWithEmptyQuery() {
        sut?.fetchPosts(with: "")
            .sink(receiveCompletion: { _ in }, receiveValue: { posts in
                XCTAssertEqual(posts.count, 1)
                XCTAssertEqual(posts.first?.title, "Porcupine")
            })
            .store(in: &cancellables)
    }
    
    func test_fetchPostsWithSomeQuery() {
        sut?.fetchPosts(with: "Owl")
            .sink(receiveCompletion: { _ in }, receiveValue: { posts in
                XCTAssertEqual(posts.count, 1)
                XCTAssertEqual(posts.first?.title, "Owl")
            })
            .store(in: &cancellables)
    }
    
}
