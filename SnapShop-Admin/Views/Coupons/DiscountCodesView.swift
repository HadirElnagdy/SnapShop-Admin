//
//  DiscountCodesView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct DiscountCodesView: View {
    
    let ruleId: String
    @ObservedObject var viewModel = DiscountCodeViewModel()
    @State private var showAlert = false
    @State private var deletionIndex: Int?
    @State private var isEditing = false
    @State private var newCodeName = ""
    
    
    var body: some View {
        if viewModel.isLoading {
            LoadingLottieView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear{
                    viewModel.getDiscountCodes(ruleId: ruleId)
                }
        }else{
            GeometryReader { geo in
                VStack{
                    if viewModel.discountCodes.isEmpty {
                        ContentUnavailableView(title: "No codes added yet!", imageName: "tag")
                    }
                    else{
                        List {
                            ForEach(viewModel.discountCodes, id: \.id) { code in
                                Text(code.code)
                            }
                            .onDelete(perform: { indexSet in
                                if let index = indexSet.first {
                                    deletionIndex = index
                                    showAlert.toggle()
                                }
                            })
                        }.listStyle(.plain)
                        
                    }
                }
                
                .sheet(isPresented: $isEditing, content: {
                    BottomSheetView(isPresented: $isEditing, newCodeName: $newCodeName, viewModel: viewModel, ruleId: ruleId, buttonWidth: geo.size.width * 0.9, buttonHeight: geo.size.height * 0.06)
                        .presentationDetents([.fraction(0.27)])
                })
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this discount code?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let index = deletionIndex {
                                viewModel.deleteDiscountCode(ruleId: ruleId, codeId: "\(viewModel.discountCodes[index].id!)")
                                viewModel.discountCodes.remove(at: index)
                            }
                        },
                        secondaryButton: .cancel(Text("Cancel")) {
                            deletionIndex = nil
                        }
                    )
                }
                .onAppear {
                    viewModel.getDiscountCodes(ruleId: ruleId)
                }
                .navigationTitle("Discount Codes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Image(systemName: "plus.app")
                                .font(.system(size: 24))
                        }
                    }
                }
            }
        }
    }
}

struct BottomSheetView: View {
    @Binding var isPresented: Bool
    @Binding var newCodeName: String
    @ObservedObject var viewModel: DiscountCodeViewModel
    let ruleId: String
    let buttonWidth: Double
    let buttonHeight: Double
    
    var body: some View {
        VStack {
            InputWithTitleView(title: "New Code", placeholder: "Code", text: $newCodeName)
                .padding()
            AppButton(text: "Add Code", width: buttonWidth, height: buttonHeight, isFilled: true) {
                guard !newCodeName.isEmpty else { return }
                viewModel.createDiscountCode(ruleId: Int(ruleId) ?? 0, code: newCodeName)
                newCodeName = ""
                isPresented = false
            }
            .padding()
        }
        .padding()
    }
}

