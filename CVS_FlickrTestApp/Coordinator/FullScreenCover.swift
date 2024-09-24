//
//  FullScreenCover.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation

enum FullScreenCover: Hashable, Identifiable {
    case postList, postDetails(Post)
    
    var id: String {
        switch self {
        case let .postDetails(post):
            return post.publishDate
        default:
            return self.hashValue.description
        }
    }
}
