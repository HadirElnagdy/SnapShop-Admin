//
//  PriceRulesViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 05/06/2024.
//

import Foundation


class PriceRulesViewModel: ObservableObject {
    
    @Published var priceRules = [PriceRule]()
    
    
    func getPriceRules(){
        APIClient.getPriceRules { [weak self] result in
            switch result {
            case .success(let response):
                self?.priceRules = response.priceRules ?? []
            case .failure(let failure):
                print("Error fetching priceRules: \(failure.localizedDescription)")
            }
        }
    }
    
    func deletePriceRule(ruleId: String) {
        APIClient.deletePriceRule(ruleId: ruleId) { result in
            switch result {
            case .success:
                print("Price rule Deleted Successfully!")
            case .failure(let error):
                print("Failed to delete price rule: \(error.localizedDescription)")
            }
        }
    }
    
}
