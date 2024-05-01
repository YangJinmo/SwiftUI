//
//  NewMockDataService_Tests.swift
//  Utils_Tests
//
//  Created by Jmy on 5/2/24.
//

import Combine
@testable import Utils
import XCTest

final class NewMockDataService_Tests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        // Given
        let items: [String]? = nil

        // When
        let dataService = NewMockDataService(items: items)

        // Then
        XCTAssertFalse(dataService.items.isEmpty)
    }
}
