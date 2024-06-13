//
//  APIClient_Tests.swift
//  SnapShop-AdminTests
//
//  Created by Hadir on 13/06/2024.
//

import XCTest
@testable import SnapShop_Admin

final class APIClient_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAllProductsSuccess_responseNotNil() {
            
            let expectation = self.expectation(description: "Successful getAllProducts request")
            
            APIClient.getAllProducts { result in
                switch result {
                case .success(let response):
                    XCTAssertNotNil(response)
                    expectation.fulfill()
                case .failure:
                    XCTFail("Expected success, got failure")
                }
            }
            
            waitForExpectations(timeout: 5, handler: nil)
        }

}
