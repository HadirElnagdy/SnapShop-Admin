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
    @Published var userError: NetworkError? = nil
    var apiClient: APIClientType.Type
    
    init(apiClient: APIClientType.Type = APIClient.self) {
        self.apiClient = apiClient
    }
    
    
    func createPriceRule(rule: PriceRuleRequest){
        apiClient.createPriceRule(rule: rule) {[weak self] result in
            switch result {
            case .success(let createdRule):
                self?.userError = nil
                self?.priceRules.append(createdRule.priceRule)
                print("Rule created: \(createdRule.priceRule)")
            case .failure(let error):
                self?.userError = error
                print("Failed to create rule: \(error.localizedDescription)")
            }
        }
    }
    
    func getPriceRules(){
        apiClient.getPriceRules { [weak self] result in
            switch result {
            case .success(let response):
                self?.userError = nil
                self?.priceRules = response.priceRules ?? []
                self?.isLoading = false
            case .failure(let failure):
                self?.userError = failure
                self?.isLoading = false
                print("Error fetching priceRules: \(failure.localizedDescription)")
            }
        }
    }
    
    func deletePriceRule(ruleId: String) {
        apiClient.deletePriceRule(ruleId: ruleId) { [weak self] result in
            switch result {
            case .success:
                self?.userError = nil
                print("Price rule Deleted Successfully!")
            case .failure(let error):
                self?.userError = error
                print("Failed to delete price rule: \(error.localizedDescription)")
            }
        }
    }
    
}
