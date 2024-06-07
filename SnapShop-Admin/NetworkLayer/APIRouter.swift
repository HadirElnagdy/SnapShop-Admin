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
    
    var method: HTTPMethod {
        switch self {
        case .getProducts, .getCollections:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getProducts, .getCollections:
            return URLEncoding.default
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getProducts, .getCollections:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return ShopifyResource.products.endpoint
        case .getCollections:
            return ShopifyResource.collections.endpoint
        }
    }
    
    var authorizationHeader: HTTPHeaderField? {
        switch self {
        case .getProducts, .getCollections:
            return .basicAuthorization
        }
    }
    
    var authorizationType: AuthorizationType {
        switch self {
        case .getProducts, .getCollections:
            return .basic
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
