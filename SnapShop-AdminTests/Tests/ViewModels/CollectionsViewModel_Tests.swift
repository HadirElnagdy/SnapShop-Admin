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
        let expectation = XCTestExpectation(description: "Fetch products successfully")
        
        // When
        viewModel.getCollections()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.collections.count, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testCreateCollectionSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Create product successfully")
        
        // When
        viewModel.collectionName = "Testing Collection"
        viewModel.collectionImageURL = "@testing collection URL"
        viewModel.createCollection()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.collections.count, 1)
            XCTAssertEqual(self.viewModel.collections.last?.title, self.viewModel.collectionName.uppercased())
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testDeleteCollectionSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Delete product successfully")
        let collectionToDelete = Collection(id: 2, title: "Deleted collection", image: nil)
        viewModel.collections = [collectionToDelete]
        
        // When
        viewModel.deleteCollection(collection: collectionToDelete)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.viewModel.collections.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

}
