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

        // app.launchArguments = ["-UITest_startSignedIn"]
        // app.launchEnvironment = ["-UITest_startSignedIn" : "true"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UITestingBootcampView_signUpButton_shouldNotSignIn() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: false)

        // When
        let navBar = app.navigationBars["Welcome"]

        // Then
        XCTAssertFalse(navBar.exists)
    }

    func test_UITestingBootcampView_signUpButton_shouldSignIn() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)

        // When
        let navBar = app.navigationBars["Welcome"]

        // Then
        XCTAssertTrue(navBar.exists)
    }

    func test_SignedInHomeView_showAlertButton_shouldDisplay() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)

        // When
        tapAlertButton(shouldDismissAlert: false)

        // Then
        // let alert = app.alerts["Welcome to the app!"]
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }

    func test_SignedInHomeView_showAlertButton_shouldDisplayAndDismissAlert() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)

        // When
        tapAlertButton(shouldDismissAlert: true)

        // Then
        let alertExists = app.alerts.firstMatch.waitForExistence(timeout: 5)
        XCTAssertFalse(alertExists)
    }

    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestination() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)

        // When
        tapNavigationLink(shouldDismissDestination: false)

        // Then
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)
    }

    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        // Given
        signUpAndSignIn(shouldTypeOnKeyboard: true)

        // When
        tapNavigationLink(shouldDismissDestination: true)

        // Then
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
    }
}

// MARK: FUNCTIONS

extension UITestingBootcampView_UITests {
    func signUpAndSignIn(shouldTypeOnKeyboard: Bool) {
        // let textField = app.textFields["Add your name..."]
        let textField = app.textFields["SignUpTextField"]
        textField.tap()

        if shouldTypeOnKeyboard {
            let keyA = app.keys["A"]

            if !keyA.exists {
                let nextKeyboard = app.buttons["Next keyboard"]
                nextKeyboard.tap()
            }

            keyA.tap()

            let keya = app.keys["a"]
            keya.tap()
            keya.tap()
        }

        let returnButton = app.buttons["Return"]
        returnButton.tap()

        // let signUpButton = app.buttons["Sign Up"]
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
    }

    func tapAlertButton(shouldDismissAlert: Bool) {
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()

        if shouldDismissAlert {
            // let alert = app.alerts["Welcome to the app!"]
            let alert = app.alerts.firstMatch
            let alertOKButton = alert.buttons["OK"]

            // sleep(1)
            let alertOKButtonExists = alertOKButton.waitForExistence(timeout: 5)
            XCTAssertTrue(alertOKButtonExists)

            alertOKButton.tap()
        }
    }

    func tapNavigationLink(shouldDismissDestination: Bool) {
        let navLinkButton = app.buttons["NavigationLinkToDestination"]
        navLinkButton.tap()

        if shouldDismissDestination {
            let backButton = app.navigationBars.buttons["Welcome"]
            backButton.tap()
        }
    }
}
