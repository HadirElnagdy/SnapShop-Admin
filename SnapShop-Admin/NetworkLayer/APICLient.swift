//
//  APIClient.swift
//  SnapShop-Admin
//
//  Created by Hadir on 02/06/2024.
//

import Foundation
import Alamofire


class APIClient {
    
    private static func performRequest<T: Decodable> (route: APIRoute, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard AppCommon.shared.isNetworkReachable() else {
            completion(.failure(.networkUnreachable))
            return
        }
        if let requestBody = try? JSONSerialization.data(withJSONObject: route.parameters ?? [:], options: .prettyPrinted),
           let requestBodyString = String(data: requestBody, encoding: .utf8) {
            print("Request Body:")
            print(requestBodyString)
        }
        AF.request(route).validate()
            .responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    do {
                        guard let data = response.data else {
                            completion(.failure(.invalidResponse))
                            return
                        }
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if (json as? [String: Any])?["Message"] is String {
                            completion(.failure(.decodingError))
                        } else {
                            completion(.failure(.serverError(error.localizedDescription)))
                        }
                    } catch {
                        completion(.failure(.other(error.localizedDescription)))
                    }
                    break
                }
            }
    }
    
    static func getAllProducts(completion: @escaping (Result<ProductsResponse, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getProducts, completion: completion)
    }
    
    static func getAllCollections(completion: @escaping (Result<CollectionsResponse, NetworkError>) -> Void) {
        performRequest(route: APIRoute.getCollections, completion: completion)
    }
    
    static func getPriceRules(completion: @escaping (Result<PriceRulesResponse, NetworkError>) -> Void){
        performRequest(route: APIRoute.getPriceRules, completion: completion)
    }
    
    
}
