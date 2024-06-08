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
