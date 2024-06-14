//
//  ProductsViewModel_Tests.swift
//  SnapShop-AdminTests
//
//  Created by Hadir on 13/06/2024.
//

import XCTest
@testable import SnapShop_Admin

final class ProductsViewModel_Tests: XCTestCase {
    
    var viewModel: ProductsViewModel!
    
    
    override func setUp() {
        super.setUp()
        viewModel = ProductsViewModel(apiClient: MockAPIClient.self)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetProductsSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch products successfully")
        MockAPIClient.shouldReturnError = false
        
        // When
        viewModel.getProducts()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.productList.count, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testGetProductsFailure() {
        //Given
           MockAPIClient.shouldReturnError = true
           let expectation = self.expectation(description: "Products fetch failed")
           
        //When
           viewModel.getProducts()
           
        //Then
           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               XCTAssertTrue(self.viewModel.isLoading)
               XCTAssertEqual(self.viewModel.productList.count, 0)
               expectation.fulfill()
           }
           
           waitForExpectations(timeout: 5, handler: nil)
       }
    
    func testCreateProductSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Create product successfully")
        
        // When
        let newProduct = Product(id: 1, title: "Testing Product", description: "Testing Product description", vendor: "Testing Product vendor", productType: "Testing Product type", tags: "Testing Product tags", variants: [Variant(price: "30", inventoryQuantity: 11)], images: nil)
        viewModel.createProduct(product: ProductRequest(product: newProduct))
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.productList.count, 1)
            XCTAssertEqual(self.viewModel.productList.last?.title, newProduct.title)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testDeleteProductSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Delete product successfully")
        let productToDelete = Product(id: 1, title: "Testing Product", description: "Testing Product description", vendor: "Testing Product vendor", productType: "Testing Product type", tags: "Testing Product tags", variants: [Variant(price: "30", inventoryQuantity: 11)], images: nil)
        viewModel.productList = [productToDelete]
        
        // When
        viewModel.deleteProduct(product: productToDelete)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.viewModel.productList.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}

