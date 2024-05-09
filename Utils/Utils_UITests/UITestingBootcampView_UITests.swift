//
//  UITestingBootcampView_UITests.swift
//  Utils_UITests
//
//  Created by Jmy on 5/10/24.
//

import XCTest

final class UITestingBootcampView_UITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
