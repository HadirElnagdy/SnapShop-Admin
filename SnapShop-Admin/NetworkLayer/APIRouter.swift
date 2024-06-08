//
//  APIRouter.swift
//  SnapShop-Admin
//
//  Created by Hadir on 02/06/2024.
//

import Foundation
import Alamofire

enum APIRoute: URLRequestConvertible {
    
    case getProducts
    case getCollections
    case getPriceRules
    case getDiscountCodes(ruleId: String)
    case deleteProduct(productId: String)
    case deleteCollection(collectionId: String)
    case createCollection(collection: CollectionRequest)
    
    var method: HTTPMethod {
        switch self {
        case .getProducts, .getCollections, .getPriceRules, .getDiscountCodes:
            return .get
        case .deleteProduct, .deleteCollection:
            return .delete
        case .createCollection(collection: let collection):
            return .post
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getProducts, .getCollections, .getPriceRules, .getDiscountCodes, .deleteProduct, .deleteCollection:
            return URLEncoding.default
        case .createCollection(collection: let collection):
            return JSONEncoding.default
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getProducts, .getCollections, .getPriceRules, .getDiscountCodes, .deleteProduct, .deleteCollection:
            return nil
        case .createCollection(let collection):
            return try? JSONSerialization.jsonObject(with: JSONEncoder().encode(collection)) as? [String: Any]
        }
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return ShopifyResource.products.endpoint
        case .getCollections, .createCollection:
            return ShopifyResource.collections.endpoint
        case .getPriceRules:
            return ShopifyResource.priceRules.endpoint
        case .getDiscountCodes(let ruleId):
            return "\(ShopifyResource.priceRules.endpoint)/\(ruleId)/\(ShopifyResource.discountCodes.endpoint)"
        case .deleteProduct(let productId):
            return "\(ShopifyResource.products.endpoint)/\(productId)"
        case .deleteCollection(let collectionId):
            return "\(ShopifyResource.collections.endpoint)/\(collectionId)"
        }
    }
    
    var authorizationHeader: HTTPHeaderField? {
        switch self {
        case .getProducts, .getCollections, .getPriceRules, .getDiscountCodes, .deleteProduct, .deleteCollection:
            return .basicAuthorization
        case .createCollection:
            return .apiKeyAuthorization
        }
    }
    
    var authorizationType: AuthorizationType {
        switch self {
        case .getProducts, .getCollections, .getPriceRules, .getDiscountCodes, .deleteProduct, .deleteCollection:
            return .basic
        case .createCollection:
            return .apiKey
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path + ".json"))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let headerField = authorizationHeader {
            urlRequest.setValue(authorizationType.headerValue(), forHTTPHeaderField: headerField.rawValue)
        }
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
