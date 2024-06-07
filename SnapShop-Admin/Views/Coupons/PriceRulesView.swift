//
//  CouponsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct PriceRulesView: View {
    @ObservedObject var viewModel = PriceRulesViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack{
                //search bar
                List(viewModel.priceRules){ rule in
                    PriceRuleCell(priceRule: rule)

                }
            }
            .navigationBarTitle("Price Rules")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        
                    }label: {
                        Image(systemName: "plus.app")
                            .font(.system(size: 24))
                    }
                }
            }.onAppear{
                viewModel.getPriceRules()
            }
        }
    }
}

#Preview {
    PriceRulesView()
}
