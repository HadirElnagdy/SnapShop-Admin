//
//  CollectionsViewModel_Tests.swift
//  SnapShop-AdminTests
//
//  Created by Hadir on 13/06/2024.
//

import XCTest
@testable import SnapShop_Admin

final class CollectionsViewModel_Tests: XCTestCase {

    
    var viewModel: CollectionsViewModel!
    
    
    override func setUp() {
        super.setUp()
        viewModel = CollectionsViewModel(apiClient: MockAPIClient.self)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetCollectionsSuccess() {
        // Given
        MockAPIClient.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Fetch collections successfully")
        
        // When
        viewModel.getCollections()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.collections.count, 1)
            XCTAssertNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testGetCollectionsFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch collections failed")
        
        // When
        viewModel.getCollections()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.collections.count, 0)
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testCreateCollectionSuccess() {
        // Given
        MockAPIClient.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Create collection successfully")
        
        // When
        viewModel.collectionName = "Testing Collection"
        viewModel.collectionImageURL = "@testing collection URL"
        viewModel.createCollection()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.collections.count, 1)
            XCTAssertEqual(self.viewModel.collections.last?.title, self.viewModel.collectionName.uppercased())
            XCTAssertNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testCreateCollectionFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Create collection failed")
        
        // When
        viewModel.collectionName = "Testing Collection"
        viewModel.collectionImageURL = "@testing collection URL"
        viewModel.createCollection()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testUpdateCollectionFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "update collection failed")
        
        // When
        viewModel.updateCollection(collection: CollectionRequest(collection: Collection(id: 1, title: "testing title", image: nil)))
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testDeleteCollectionSuccess() {
        // Given
        MockAPIClient.shouldReturnError = false
        let expectation = XCTestExpectation(description: "Delete collection successfully")
        let collectionToDelete = Collection(id: 2, title: "Deleted collection", image: nil)
        viewModel.collections = [collectionToDelete]
        
        // When
        viewModel.deleteCollection(collection: collectionToDelete)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.viewModel.collections.isEmpty)
            XCTAssertNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testDeleteCollectionFailure() {
        // Given
        MockAPIClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Delete collection successfully")
        let collectionToDelete = Collection(id: 2, title: "Deleted collection", image: nil)
        viewModel.collections = [collectionToDelete]
        
        // When
        viewModel.deleteCollection(collection: collectionToDelete)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel.userError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

}
