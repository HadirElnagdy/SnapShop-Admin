//
//  AddPriceRuleView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 09/06/2024.
//

import SwiftUI

struct AddPriceRuleView: View {
    
    var addPriceRuleAction: (PriceRuleRequest) -> Void
    @State private var name = ""
    @State private var discountValue = ""
    @State private var selectedValueType: ValueType = .percentage
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var oncePerCustomer = true
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                InputWithTitleView(title: "Name", placeholder: "Price Rule Name", text: $name)
                InputWithTitleView(title: "Value", placeholder: "Discount value", text: $discountValue)
                
                HStack {
                    Text("Value Type: ")
                    Picker("Value Type", selection: $selectedValueType) {
                        ForEach(ValueType.allCases, id: \.self) { valueType in
                            Text(valueType.rawValue).tag(valueType)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                }
                
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                
                Toggle(isOn: $oncePerCustomer) {
                    Text("Once Per Customer")
                }
                
                Spacer()
                
                AppButton(text: "Add Rule", width: geo.size.width * 0.9, height: geo.size.height * 0.06, isFilled: true) {
                    if validateFields() {
                        let start = DateFormatterHelper.shared.convertToIsoFormat(startDate)
                        let end = DateFormatterHelper.shared.convertToIsoFormat(endDate)
                        let newRule = PriceRuleRequest(priceRule: PriceRule(title: name, valueType: selectedValueType.type, value: "-\(discountValue)", oncePerCustomer: oncePerCustomer, startsAt: start, endsAt: end))
                        
                        addPriceRuleAction(newRule)
                        dismiss()
                    } else {
                        showAlert = true
                    }
                }
                .padding(.bottom, 50)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Validation Error"),
                        message: Text("Please fill in all fields."),
                        dismissButton: .default(Text("OK")) {
                            showAlert = false
                        }
                    )
                }
            }
            .padding()
        }
    }
    
    private func validateFields() -> Bool {
        guard !name.isEmpty,
              !discountValue.isEmpty else {
            return false
        }
        return true
    }
}

struct AddPriceRuleView_Previews: PreviewProvider {
    static var previews: some View {
        AddPriceRuleView() { _ in }
    }
}
