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
    
    static func deleteProduct(productId: String, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(Empty()))
        }
    }
    
    static func getAllCollections(completion: @escaping (Result<CollectionsResponse, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            let collections = [Collection(id: 1, title: "Mock collection 1", bodyHTML: "Mock collection body HTML", image: nil)]
            completion(.success(CollectionsResponse(collections: collections)))
        }
    }
    
    static func getPriceRules(completion: @escaping (Result<PriceRulesResponse, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            let priceRules = [PriceRule(id: 1, title: "Mock price rule 1", valueType: "Percentage", value: "10")]
            completion(.success(PriceRulesResponse(priceRules: priceRules)))
        }
    }
    
    static func getDiscountCodes(ruleId: String, completion: @escaping (Result<DiscountCodesResponse, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            let discountCodes = [DiscountCode(id: 1, priceRuleId: 1, code: "MOCKCODE")]
            completion(.success(DiscountCodesResponse(discountCodes: discountCodes)))
        }
    }
    
    static func deleteCollection(collectionId: String, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(Empty()))
        }
    }
    
    static func deletePriceRule(ruleId: String, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(Empty()))
        }
    }
    
    static func deleteDiscountCodes(ruleId: String, codeId: String, completion: @escaping (Result<Empty, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(Empty()))
        }
    }
    
    static func createCollection(collection: CollectionRequest, completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(collection))
        }
    }
    
    static func createPriceRule(rule: PriceRuleRequest, completion: @escaping (Result<PriceRuleRequest, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(rule))
        }
    }
    
    static func createDiscountCodes(codes: DiscountCodesResponse, completion: @escaping (Result<DiscountCodeCreationResponse, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            let response = DiscountCodeCreationResponse(discountCodeCreation: DiscountCodeCreation(id: 1, priceRuleID: 1, startedAt: "", completedAt: "", createdAt: "", updatedAt: "", status: "", codesCount: 2, importedCount: 2, failedCount: 0))
            completion(.success(response))
        }
    }
    
    static func updateCollection(collection: CollectionRequest, completion: @escaping (Result<CollectionRequest, NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.other("Mock error!")))
        } else {
            completion(.success(collection))
        }
    }
}
