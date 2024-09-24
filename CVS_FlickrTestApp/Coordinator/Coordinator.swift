//
//  Coordinator.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func present(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

extension Coordinator {
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .postList:
            PostListView(viewModel: .init(flickrService: FlickrWebService.shared))
        case let .postDetails(post):
            PostDetailsView(post: post)
        }
    }
}

extension Coordinator {
    @ViewBuilder
    func build(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .postList:
            PostListView(viewModel: .init(flickrService: FlickrWebService.shared))
        case let .postDetails(post):
            PostDetailsView(post: post)
        }
    }
}

extension Coordinator {
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .postList:
            PostListView(viewModel: .init(flickrService: FlickrWebService.shared))
        case let .postDetails(post):
            PostDetailsView(post: post)
        }
    }
}
