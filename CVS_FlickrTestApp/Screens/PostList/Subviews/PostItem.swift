//
//  PostItem.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/24/24.
//

import SwiftUI

struct PostItem: View {
    
    var post: Post
    
    var body: some View {
        ZStack {
            Color.white
            PostImageView(post: post)
        }
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.blue)
        )
    }
}

private struct PostImageView: View {
    
    var post: Post
    
    var body: some View {
        AsyncImage(url: .init(string: post.imageUrl)) { image in
            if let image = image.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } else {
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            }
            
        }
    }
}

