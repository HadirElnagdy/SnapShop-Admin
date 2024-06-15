//
//  PriceRulesViewModel_Tests.swift
//  SnapShop-AdminTests
//
//  Created by Hadir on 13/06/2024.
//

import XCTest
@testable import SnapShop_Admin

final class PriceRulesViewModel_Tests: XCTestCase {

    
    var viewModel: PriceRulesViewModel!
    
    
    override func setUp() {
        super.setUp()
        viewModel = PriceRulesViewModel(apiClient: MockAPIClient.self)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetPriceRulesSuccess() {
        // Given
        MockAPIClient.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Fetch rules successfully")
        
        // When
        viewModel.getPriceRules()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.priceRules.count, 1)
            XCTAssertEqual(self.viewModel.priceRules.last?.id, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testGetPriceRulesFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch rules failed")
        
        // When
        viewModel.getPriceRules()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.priceRules.count, 0)
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    
    func testCreatePriceRulesSuccess() {
        // Given
        MockAPIClient.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Create rule successfully")
        
        // When
        let ruleRequest = PriceRuleRequest(priceRule: PriceRule(title: "Testing Rule", valueType: "Percentage", value: "10"))
        viewModel.createPriceRule(rule: ruleRequest)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.priceRules)
            XCTAssertEqual(self.viewModel.priceRules.last?.title, ruleRequest.priceRule.title)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testCreatePriceRulesFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Create rule failed")
        
        // When
        let ruleRequest = PriceRuleRequest(priceRule: PriceRule(title: "Testing Rule", valueType: "Percentage", value: "10"))
        viewModel.createPriceRule(rule: ruleRequest)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testDeletePriceRulesFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Delete rule failed")
        
        // When
        viewModel.deletePriceRule(ruleId: "1")
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
        
    }


}
