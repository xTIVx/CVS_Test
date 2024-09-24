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
