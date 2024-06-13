//
//  MockAPIClient.swift
//  SnapShop-AdminTests
//
//  Created by Hadir on 13/06/2024.
//

import Foundation
@testable import SnapShop_Admin


class MockAPIClient: APIClientType {
   
    static var shouldReturnError = false
    
    static func getAllProducts(completion: @escaping (Result<ProductsResponse, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            let products = [Product(id: 1, title: "Mock product 1", description: "Mock product 1 description", vendor: "Mock product vendor", productType: "Mock Product type", tags: "Mock product tags", variants: [Variant(price: "30", inventoryQuantity: 11)], images: nil)]
            completion(.success(ProductsResponse(products: products)))
        }
    }
    
    static func createProduct(product: ProductRequest, completion: @escaping (Result<ProductRequest, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(product))
        }
    }
    
    static func updateProduct(product: ProductRequest, completion: @escaping (Result<ProductRequest, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(product))
        }
    }
    
    static func deleteProduct(productId: String, completion: @escaping (Result<Empty, NetworkError>) -> Void){
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(Empty()))
        }
    }
    
    
    static func getAllCollections(completion: @escaping (Result<SnapShop_Admin.CollectionsResponse, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func getPriceRules(completion: @escaping (Result<SnapShop_Admin.PriceRulesResponse, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func getDiscountCodes(ruleId: String, completion: @escaping (Result<SnapShop_Admin.DiscountCodesResponse, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func deleteCollection(collectionId: String, completion: @escaping (Result<SnapShop_Admin.Empty, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func deletePriceRule(ruleId: String, completion: @escaping (Result<SnapShop_Admin.Empty, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func deleteDiscountCodes(ruleId: String, codeId: String, completion: @escaping (Result<SnapShop_Admin.Empty, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func createCollection(collection: SnapShop_Admin.CollectionRequest, completion: @escaping (Result<SnapShop_Admin.CollectionRequest, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func createPriceRule(rule: SnapShop_Admin.PriceRuleRequest, completion: @escaping (Result<SnapShop_Admin.PriceRuleRequest, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func createDiscountCodes(codes: SnapShop_Admin.DiscountCodesResponse, completion: @escaping (Result<SnapShop_Admin.DiscountCodeCreationResponse, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    static func updateCollection(collection: SnapShop_Admin.CollectionRequest, completion: @escaping (Result<SnapShop_Admin.CollectionRequest, SnapShop_Admin.NetworkError>) -> Void) {
        
    }
    
    
    
}
