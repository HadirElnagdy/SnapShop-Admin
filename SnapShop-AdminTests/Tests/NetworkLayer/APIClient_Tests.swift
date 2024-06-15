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
        //Given
        let expectation = self.expectation(description: "Successful getAllProducts request")
        
        //When
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
    
    func testGetAllCollectionsSuccess_responseNotNil() {
        
        let expectation = self.expectation(description: "Successful getAllCollections request")
        
        APIClient.getAllCollections { result in
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
    
    func testGetPriceRulesSuccess_responseNotNil() {
        //Given
        let expectation = self.expectation(description: "Successful getPriceRules request")
        
        //When
        APIClient.getPriceRules { result in
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
    
    func testGetDiscountCodesSuccess_responseNotNil() {
        
        let expectation = self.expectation(description: "Successful getAllProducts request")
        
        APIClient.getDiscountCodes(ruleId: "1124387160243") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.discountCodes?.count, 3)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
//    func testCreateProductSuccess() {
//        
//        let expectation = self.expectation(description: "Successful createProduct request")
//        let productRequest = ProductRequest(product: Product(title: "testing product", description: "", vendor: "", productType: "", tags: "", variants: nil, images: nil))
//  //this will probably fail 
//
//        APIClient.createProduct(product: productRequest){ result in
//            switch result {
//            case .success(let success):
//                XCTAssertNotNil(success)
//                expectation.fulfill()
//            case .failure(let failure):
//                XCTFail("Expected success, got failure")
//            }
//        }
//        waitForExpectations(timeout: 5, handler: nil)
//    }
    
    
    
}
