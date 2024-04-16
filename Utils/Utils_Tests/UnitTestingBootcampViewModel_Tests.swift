//
//  UnitTestingBootcampViewModel_Tests.swift
//  Utils_Tests
//
//  Created by Jmy on 4/11/24.
//

@testable import Utils
import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

final class UnitTestingBootcampViewModel_Tests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true

        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)

        // Then
        XCTAssertTrue(vm.isPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false

        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)

        // Then
        XCTAssertFalse(vm.isPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()

        // When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)

        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0 ..< 100 {
            // Given
            let userIsPremium: Bool = Bool.random()

            // When
            let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)

            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty() {
        for _ in 0 ..< 100 {
            // Given

            // When
            let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

            // Then
            XCTAssertTrue(vm.dataArray.isEmpty)
            XCTAssertEqual(vm.dataArray.count, 0)
        }
    }

    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItems() {
        for _ in 0 ..< 100 {
            // Given
            let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

            // When
            vm.addItem(item: "hello")

            // Then
            XCTAssertTrue(!vm.dataArray.isEmpty)
            XCTAssertFalse(vm.dataArray.isEmpty)
            XCTAssertEqual(vm.dataArray.count, 1)
            XCTAssertNotEqual(vm.dataArray.count, 0)
            XCTAssertGreaterThan(vm.dataArray.count, 0)
        }
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString() {
        for _ in 0 ..< 100 {
            // Given
            let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

            // When
            vm.addItem(item: "")

            // Then
            XCTAssertTrue(vm.dataArray.isEmpty)
        }
    }
}
