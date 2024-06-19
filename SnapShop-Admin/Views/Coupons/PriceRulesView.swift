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
            if viewModel.isLoading{
                LoadingLottieView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onAppear {
                        viewModel.getPriceRules()
                    }
            }else{
                VStack {
                    if viewModel.priceRules.isEmpty {
                        ContentUnavailableView(title: "No rules!", imageName: "tag")
                    }else{
                        List {
                            ForEach(viewModel.priceRules) { rule in
                                PriceRuleCell(priceRule: rule)
                                    .listRowSeparator(.hidden)
                            }
                            .onDelete(perform: { indexSet in
                                if let index = indexSet.first {
                                    deletionIndex = index
                                    showAlert.toggle()
                                }
                            })
                        }
                        .listStyle(.plain)
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
                                        viewModel.createPriceRule(rule: rule)
                                    }
                                }
                            }
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
        }.showAlert(for: $viewModel.userError)
    }
}

#Preview {
    PriceRulesView()
}
