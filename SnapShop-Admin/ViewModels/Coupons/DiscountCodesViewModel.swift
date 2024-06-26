//
//  DiscountCodesViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 06/06/2024.
//

import Foundation


class DiscountCodeViewModel: ObservableObject {
    
    @Published var discountCodes = [DiscountCode]()
    @Published var userError: NetworkError? = nil
    @Published var isLoading = true
    var apiClient: APIClientType.Type
    
    init(apiClient: APIClientType.Type = APIClient.self) {
        self.apiClient = apiClient
    }
    
    
    func getDiscountCodes(ruleId: String) {
        apiClient.getDiscountCodes(ruleId: ruleId) { [weak self] result in
            print("Fetching codes ...")
            switch result {
            case .success(let codes):
                print("Codes are here!")
                self?.isLoading = false
                self?.userError = nil
                self?.discountCodes = codes.discountCodes ?? []
            case .failure(let error):
                self?.isLoading = false
                self?.userError = error
                print("Failed to fetch discount codes: \(error.localizedDescription)")
            }
        }
    }
    
    func createDiscountCode(ruleId: Int, code: String) {
        let dicountCodeRequest = DiscountCodesResponse(discountCodes: [DiscountCode(priceRuleId: ruleId, code: code)])
        apiClient.createDiscountCodes(codes: dicountCodeRequest) {[weak self] result in
            switch result {
            case .success(let response):
                self?.userError = nil
                let createdCode = DiscountCode(id: response.discountCodeCreation.id, priceRuleId: response.discountCodeCreation.priceRuleID, code: code)
                self?.discountCodes.append(createdCode)
            case .failure(let error):
                self?.userError = error
                print("Failed to create discount codes: \(error.localizedDescription)")
            }
        }
    }
    
    
    func deleteDiscountCode(ruleId: String, codeId: String) {
        apiClient.deleteDiscountCodes(ruleId: ruleId, codeId: codeId) { [weak self] result in
            switch result {
            case .success:
                self?.userError = nil
                print("Discount code deleted successfully!")
            case .failure(let error):
                print("Failed to delete discount code: \(error.localizedDescription)")
            }
        }
    }
}
