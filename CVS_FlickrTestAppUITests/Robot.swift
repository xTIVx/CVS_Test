//
//  Robot.swift
//  CVS_FlickrTestAppUITests
//
//  Created by Igor Chernobai on 9/24/24.
//

import Foundation
import XCTest

public var mainBundleIdentifier = "com.codeWave.tiv.CVS-FlickrTestApp"
public var app = XCUIApplication(bundleIdentifier: mainBundleIdentifier)

final class Robot: XCTestCase {
    
    @discardableResult
    func validateProgressViewIsVisible() -> Robot {
        let progressView = app.staticTexts[AppUIProperties.Elements.progressView.identifier]
        XCTAssertTrue(progressView.waitForExistence(timeout: 5))
        XCTAssertTrue(progressView.exists)
        return self
    }
    
    @discardableResult
    func validatePostListNavigationTitle() -> Robot {
        let navigationTitle = app.staticTexts[AppUIProperties.Titles.postList.identifier]
        XCTAssertTrue(navigationTitle.exists)
        return self
    }
    
    @discardableResult
    func validateSearchField() -> Robot {
        let searchField = app.searchFields["Search"]
        XCTAssertTrue(searchField.exists, "Search field should exist")
        
        searchField.tap()
        searchField.typeText("owl")
        
        XCTAssertEqual(searchField.value as? String, "owl")
        
        return self
    }
}

class App: XCUIApplication {
    public override init(bundleIdentifier: String = mainBundleIdentifier) {
        super.init(bundleIdentifier: bundleIdentifier)
        self.launch()
    }

    func chainToRobot() -> Robot {
        return Robot()
    }
}

struct AppUIProperties {
    enum Titles {
        case postList
        
        var identifier: String {
            switch self {
            case .postList:
                return "Posts"
            }
        }
    }
    
    enum Elements {
        case progressView

        var identifier: String {
            switch self {
            case .progressView:
                return "Loading"
            }
        }
    }
}


struct DetailView: View {
    let item: Item
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if let imageUrlString = item.media?.m, let imageUrl = URL(string: imageUrlString) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .background(Color.gray.opacity(0.3))
                    }
                }
                
                Text(Helper.shared.cleanName(title: item.title ?? TextPhrases.noDataFound.rawValue))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(item.description?.stripHTML() ?? TextPhrases.noDataFound.rawValue)
                    .padding(.top, 5)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Author: \(Helper.shared.cleanName(title: item.author ?? TextPhrases.noDataFound.rawValue))")
                    .padding(.top, 5)
                    .fixedSize(horizontal: false, vertical: true)
                
                if let publishedDate = item.published {
                    Text("Published: \(Helper.shared.formattedDate(from: publishedDate))")
                        .padding(.top, 5)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                if let dimensions = Helper.shared.extractImageDimensions(from: item.description) {
                    Text("Image Size: \(dimensions)")
                        .padding(.top, 5)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                // MARK: - Share Button
                
                if let imageUrlString = item.media?.m, let imageUrl = URL(string: imageUrlString) {
                    ShareLink(item: generateShareableContent(from: imageUrl)) {
                        Label("Share", systemImage: SystemImages.squareArrowUP.rawValue)
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
            .padding(10)
        }
    }
    
    // MARK: - Generate Shareable Content
    private func generateShareableContent(from imageUrl: URL) -> String {
        let shareableContent = """
            Title: \(Helper.shared.cleanName(title: item.title ?? TextPhrases.noDataFound.rawValue))
            Description: \(item.description?.stripHTML() ?? TextPhrases.noDataFound.rawValue)
            Author: \(Helper.shared.cleanName(title: item.author ?? TextPhrases.noDataFound.rawValue))
            Published: \(Helper.shared.formattedDate(from: item.published ?? TextPhrases.noDataFound.rawValue))
            Image URL: \(imageUrl.absoluteString)
            """
        return shareableContent
    }
}
