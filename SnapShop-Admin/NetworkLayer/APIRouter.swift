//
//  APIRouter.swift
//  SnapShop-Admin
//
//  Created by Hadir on 02/06/2024.
//

import Foundation
import Alamofire

enum APIRoute: URLRequestConvertible {
    
   
    
    var method: HTTPMethod {
        switch self {
      
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
       
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        
        }
    }
    
    var path: String {
        switch self {
       
        }
    }
    
    var authorizationHeader: HTTPHeaderField? {
        switch self {
        
        }
    }
    
    var authorizationType: AuthorizationType {
        switch self {
        
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
