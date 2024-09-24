//
//  CVS_FlickrTestAppUITests.swift
//  CVS_FlickrTestAppUITests
//
//  Created by Igor Chernobai on 9/23/24.
//

import XCTest

final class CVS_FlickrTestAppUITests: XCTestCase {

    func test_postListScreen() {
        App()
            .chainToRobot()
            .validatePostListNavigationTitle()
            .validateProgressViewIsVisible()
            .validateSearchField()
    }
}
