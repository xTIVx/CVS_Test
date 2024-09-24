//
//  PorcupineDetailsView.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import SwiftUI

struct PostDetailsView: View {
    
    var post: Post
    @State private var strippedDescription: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Author: \(Helper.shared.cleanName(title: post.author))")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(Color.black)
                Spacer()
                Text(post.publishDate)
                    .font(.system(size: 10, weight: .light))
                    .foregroundStyle(Color.gray)
            }
            
            PostImageView(post: post)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Color.blue)
                )

            Text(Helper.shared.cleanName(title: post.title))
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(strippedDescription)
                .padding(.top, 5)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            if let imageUrl = URL(string: post.imageUrl) {
                ShareLink(item: generateShareableContent(from: imageUrl)) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            strippedDescription = post.description.stripHTML()
        }
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

extension PostDetailsView {
    private func generateShareableContent(from imageUrl: URL) -> String {
        let shareableContent = """
            Title: \(Helper.shared.cleanName(title: post.title))
            Author: \(Helper.shared.cleanName(title: post.author))
            Published: \(Helper.shared.formattedDate(from: post.publishDate))
            Image URL: \(imageUrl.absoluteString)
            """
        return shareableContent
    }
}

#Preview {
    PostDetailsView(post: .init(title: "Test", description: "", author: "", publishDate: "", imageUrl: ""))
}
