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
    
   
    func testCreateProductSuccess(){
        let expectation = self.expectation(description: "Successful create product request")
        
        let request = ProductRequest(product: Product(title: "Testing product", description: "Product to test", vendor: "No vendor", productType: "Testing", tags: "test", variants: nil, images: nil))
        
        APIClient.createProduct(product: request){ result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testUpdateProductFailure(){
        let expectation = self.expectation(description: "Failed update product request")
        
        let request = ProductRequest(product: Product(id: 1, title: "Testing product", description: "Product to test", vendor: "No vendor", productType: "Testing", tags: "test", variants: nil, images: nil))
        
        APIClient.updateProduct(product: request){ result in
            switch result {
            case .success(let response):
                XCTFail("Expected failure, got success")
            case .failure:
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    
    func testDeleteProductFailure(){
        
        let expectation = self.expectation(description: "Failed delete product request")
        
        APIClient.deleteProduct(productId: "1"){ result in
            switch result {
            case .success(let success):
                XCTFail("Expected failure, got success")
            case .failure(let failure):
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
        
    
    func testCreateCollectionSuccess(){
        let expectation = self.expectation(description: "Successful create collection request")
        
        let request = CollectionRequest(collection: Collection(title: "Testing collection", image: nil))
        
        APIClient.createCollection(collection: request) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testUpdateCollectionFailure(){
        let expectation = self.expectation(description: "Failed update collection request")
        
        let request = CollectionRequest(collection: Collection(id: 1, title: "Testing", image: nil))
        
        APIClient.updateCollection(collection: request){ result in
            switch result {
            case .success(let response):
                XCTFail("Expected failure, got success")
            case .failure:
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    

    func testDeleteCollectionFailure() {
        let expectation = self.expectation(description: "Failed delete collection request")
        
        APIClient.deleteCollection(collectionId: "1"){ result in 
            switch result {
            case .success(let success):
                XCTFail("Expected failure, got success")
            case .failure(let failure):
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
//    func testCreatePriceRuleSuccess(){
//        let expectation = self.expectation(description: "Successful create price rule request")
//        
//        let request = PriceRuleRequest(priceRule: PriceRule(title: "Testing 10%", valueType: "percentage", value: "-10", customerSelection: "all", targetType: "line_item", targetSelection: "all", allocationMethod: "across"))
//        
//        APIClient.createPriceRule(rule: request){ result in
//            switch result {
//            case .success(let response):
//                XCTAssertNotNil(response)
//                expectation.fulfill()
//            case .failure:
//                XCTFail("Expected success, got failure")
//            }
//        }
//        
//        waitForExpectations(timeout: 10, handler: nil)
//    }
    
    func testDeletePriceRuleFailure() {
        let expectation = self.expectation(description: "Failed delete price rule request")
        
        APIClient.deletePriceRule(ruleId: "1"){ result in
            switch result {
            case .success(let success):
                XCTFail("Expected failure, got success")
            case .failure(let failure):
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    
    
    func testDeleteDiscountCodeFailure() {
        
        let expectation = self.expectation(description: "Failed delete discount code request")
        
        APIClient.deleteDiscountCodes(ruleId: "1", codeId: "1"){ result in
            switch result {
            case .success(let success):
                XCTFail("Expected failure, got success")
            case .failure(let failure):
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    
    
}
