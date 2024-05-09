//
//  UITestingBootcampView_UITests.swift
//  Utils_UITests
//
//  Created by Jmy on 5/10/24.
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct]_[ui component]_[expected result]
// Testing Structure: Given, When, Then

final class UITestingBootcampView_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false

        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UITestingBootcampView_signUpButton_shouldNotSignIn() {
    }

    func test_UITestingBootcampView_signUpButton_shouldSignIn() {
        app.textFields["Add your name..."].tap()
        app.buttons["Next keyboard"].tap()

        app.keys["A"].tap()

        let aKey = app.keys["a"]
        aKey.tap()
        aKey.tap()
        aKey.tap()
        app.buttons["Sign Up"].tap()
        app.navigationBars["Welcome"].staticTexts["Welcome"].tap()
    }
}
