//
//  DiscountCodesViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 06/06/2024.
//

import Foundation


class DiscountCodeViewModel: ObservableObject {
    
    @Published var discountCodes = [DiscountCode]()
    
    func getDiscountCodes(ruleId: String) {
        APIClient.getDiscountCodes(ruleId: ruleId) { [weak self] result in
            print("Fetching codes ...")
            switch result {
            case .success(let codes):
                print("Codes are here!")
                self?.discountCodes = codes.discountCodes ?? []
            case .failure(let error):
                print("Failed to fetch discount codes: \(error.localizedDescription)")
            }
        }
    }
    
    func createDiscountCode(ruleId: Int, code: String) {
        let dicountCodeRequest = DiscountCodesResponse(discountCodes: [DiscountCode(priceRuleId: ruleId, code: code)])
        APIClient.createDiscountCodes(codes: dicountCodeRequest) {[weak self] result in
            switch result {
            case .success(let response):
                let createdCode = DiscountCode(id: response.discountCodeCreation.id, priceRuleId: response.discountCodeCreation.priceRuleID, code: code)
                self?.discountCodes.append(createdCode)
            case .failure(let error):
                print("Failed to create discount codes: \(error.localizedDescription)")
            }
        }
    }
    
    
    func deleteDiscountCode(ruleId: String, codeId: String) {
        APIClient.deleteDiscountCodes(ruleId: ruleId, codeId: codeId) { result in
            switch result {
            case .success:
                print("Discount code deleted successfully!")
            case .failure(let error):
                print("Failed to delete discount code: \(error.localizedDescription)")
            }
        }
    }
}
