//
//  Flickr+Extension.swift
//  CVS_FlickrTestApp
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation
import Networking

extension Configuration {
    struct Flickr {
        static var baseUrl: URL {
            URL(string: "https://api.flickr.com")!
        }
        
        enum Methods: HTTPRequestProtocol {
            case getPost(query: String)
            
            var path: String {
                switch self {
                case .getPost:
                    return "/services/feeds/photos_public.gne"
                }
            }
            
            var httpHeaders: [String : String?] {
                return [:]
            }
            
            var httpMethod: HTTP.Method {
                switch self {
                case .getPost:
                    return .post
                }
            }
            
            var queryParameters: [QueryParameter]? {
                switch self {
                case let .getPost(query):
                    return [
                        .init(key: "format", value: "json"),
                        .init(key: "nojsoncallback", value: "1"),
                        .init(key: "tags", value: query)
                    ]
                }
            }
        }
    }
}
