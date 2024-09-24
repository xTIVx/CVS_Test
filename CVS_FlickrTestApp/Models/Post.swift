//
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation

struct PostDataContainer: Decodable {
    let items: [Post]
}

struct Post: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let author: String
    let publishDate: String
    let imageUrl: String
    
    init(title: String, description: String, author: String, publishDate: String, imageUrl: String) {
        self.title = title
        self.description = description
        self.author = author
        self.publishDate = publishDate
        self.imageUrl = imageUrl
    }
}

extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case author
        case publishDate = "published"
        case imageUrl = "media"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.author = try container.decode(String.self, forKey: .author)
        
        let dateString = try container.decode(String.self, forKey: .publishDate)
        let formatter = DateFormatterManager.shared
        let date = formatter.dateFromString(dateString, format: .sql)
        
        self.publishDate = date?.format(to: .standard) ?? "Unknown"
        
        let media = try container.decode(Post.Media.self, forKey: .imageUrl)
        self.imageUrl = media.m
    }
    
    struct Media: Decodable {
        let m: String
    }
}
