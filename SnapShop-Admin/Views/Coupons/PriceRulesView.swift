//
//  CouponsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct PriceRulesView: View {
    
    @ObservedObject var viewModel = PriceRulesViewModel()
    @State private var deletionIndex: Int?
    @State private var showAlert = false
    @State private var openAddPriceRule = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.priceRules) { rule in
                        NavigationLink(destination: DiscountCodesView(ruleId: "\(rule.id!)")) {
                            PriceRuleCell(priceRule: rule)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        if let index = indexSet.first {
                            deletionIndex = index
                            showAlert.toggle()
                        }
                    })
                }
                .navigationBarTitle("Price Rules")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            openAddPriceRule.toggle()
                        } label: {
                            Image(systemName: "plus.app")
                                .font(.system(size: 24))
                        }
                        .sheet(isPresented: $openAddPriceRule){
                            AddPriceRuleView(){ rule in
                                //rule creation logic here
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.getPriceRules()
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this price rule?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let index = deletionIndex {
                                let id = "\(viewModel.priceRules[index].id!)"
                                viewModel.deletePriceRule(ruleId: id)
                                viewModel.priceRules.remove(at: index)
                            }
                        },
                        secondaryButton: .cancel(Text("Cancel")) {
                            deletionIndex = nil
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    PriceRulesView()
}
