//
//  PriceRulesViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 05/06/2024.
//

import Foundation


class PriceRulesViewModel: ObservableObject {
    
    @Published var priceRules = [PriceRule]()
    @Published var isLoading = true
    
    func createPriceRule(rule: PriceRuleRequest){
        APIClient.createPriceRule(rule: rule) {[weak self] result in
            switch result {
            case .success(let createdRule):
                self?.priceRules.append(createdRule.priceRule)
                print("Rule created: \(createdRule.priceRule)")
            case .failure(let error):
                print("Failed to create rule: \(error.localizedDescription)")
            }
        }
    }
    
    func getPriceRules(){
        APIClient.getPriceRules { [weak self] result in
            switch result {
            case .success(let response):
                self?.priceRules = response.priceRules ?? []
                self?.isLoading = false
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
