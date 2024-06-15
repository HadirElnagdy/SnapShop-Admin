//
//  DiscountCodesViewModel_Tests.swift
//  SnapShop-AdminTests
//
//  Created by Hadir on 13/06/2024.
//

import XCTest
@testable import SnapShop_Admin

final class DiscountCodesViewModel_Tests: XCTestCase {

    var viewModel: DiscountCodeViewModel!
    
    
    override func setUp() {
        super.setUp()
        viewModel = DiscountCodeViewModel(apiClient: MockAPIClient.self)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetDiscountCodesSuccess() {
        // Given
        MockAPIClient.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Fetch codes successfully")
        
        // When
        viewModel.getDiscountCodes(ruleId: "1")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.discountCodes.count, 1)
            XCTAssertEqual(self.viewModel.discountCodes.last?.priceRuleId, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetDiscountCodesFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch codes successfully")
        
        // When
        viewModel.getDiscountCodes(ruleId: "1")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.discountCodes.count, 0)
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testCreateDiscountCodeSuccess() {
        // Given
        MockAPIClient.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Create code successfully")
        
        // When
        viewModel.createDiscountCode(ruleId: 1, code: "TestingCode")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.discountCodes.count, 1)
            XCTAssertEqual(self.viewModel.discountCodes.last?.code, "TestingCode")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    } 
    
    func testCreateDiscountCodeFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Create code failed")
        
        // When
        viewModel.createDiscountCode(ruleId: 1, code: "TestingCode")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    } 
    
    
    func testDeleteDiscountCodeFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Delete code failed")
        
        // When
        viewModel.deleteDiscountCode(ruleId: "1", codeId: "1")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    
   


}
