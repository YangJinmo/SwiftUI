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
        // Given
        let textField = app.textFields["Add your name..."]

        // When
        textField.tap()

        let keyA = app.keys["A"]

        if !keyA.exists {
            let nextKeyboard = app.buttons["Next keyboard"]
            nextKeyboard.tap()
        }

        keyA.tap()

        let keya = app.keys["a"]
        keya.tap()
        keya.tap()

        let returnButton = app.buttons["Return"]
        returnButton.tap()

        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()

        let navBar = app.navigationBars["Welcome"]

        // Then
        XCTAssertTrue(navBar.exists)
    }
}
