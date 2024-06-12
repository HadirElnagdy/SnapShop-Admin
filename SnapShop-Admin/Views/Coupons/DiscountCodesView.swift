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
        VStack{
            
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
            
            
            if isEditing {
                HStack {
                    TextField("New Code", text: $newCodeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        guard !newCodeName.isEmpty else { return }
                        viewModel.createDiscountCode(ruleId: Int(ruleId) ?? 0, code: newCodeName)
                        newCodeName = ""
                        isEditing = false
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .padding()
            }
        }.navigationTitle("Discount Codes")
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

//
//#Preview {
//    DiscountCodesView(ruleId: "1119217582259")
//}
