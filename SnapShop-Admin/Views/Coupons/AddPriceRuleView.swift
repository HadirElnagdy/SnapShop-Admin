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
    @State private var alertMessage = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                InputWithTitleView(title: "Name", placeholder: "Price Rule Name", text: $name)
                InputWithTitleView(title: "Value", placeholder: "Discount value", text: $discountValue)
                    .keyboardType(.decimalPad)
                
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
                
                DatePicker("Start Date", selection: $startDate, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
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
                        message: Text(alertMessage),
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
            guard let discountValue = Double(discountValue) else {
                alertMessage = "Please enter a valid number for discount value."
                return false
            }
            
            switch selectedValueType {
            case .percentage:
                if discountValue < 1 || discountValue > 100 {
                    alertMessage = "Discount percentage must be between 1 and 100."
                    return false
                }
            case .fixed:
                if discountValue <= 0 {
                    alertMessage = "Fixed amount discount must be greater than 0."
                    return false
                }
            }
            
            if name.isEmpty {
                alertMessage = "Rule name cannot be empty."
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
