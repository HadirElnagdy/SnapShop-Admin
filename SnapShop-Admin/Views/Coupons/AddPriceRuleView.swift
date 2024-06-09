//
//  AddPriceRuleView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 09/06/2024.
//

import SwiftUI

struct AddPriceRuleView: View {
    
    var addPriceRuleAction: (PriceRuleRequest) -> Void
    @State var name = ""
    @State var discountValue = ""
    @State var selectedValueType: ValueType = .percentage
    @State var startDate = Date()
    @State var endDate = Date()
    @State var oncePerCustomer = true
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            InputWithTitleView(title: "Name", placeholder: "Price Rule Name", text: $name)
            InputWithTitleView(title: "Value", placeholder: "Discount value", text: $discountValue)
            
            HStack(content: {
                Text("Value Type: ")
                Picker("Value Type", selection: $selectedValueType) {
                    ForEach(ValueType.allCases, id: \.self) { valueType in
                        Text(valueType.rawValue).tag(valueType)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
            })
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
            
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .datePickerStyle(DefaultDatePickerStyle())
            
            Toggle(isOn: $oncePerCustomer) {
                            Text("Once Per Customer")
                        }
            
            Spacer()
            AppButton(text: "Add Rule", width: 350, height: 50, isFilled: true) {
                let start = DateFormatterHelper.shared.convertToIsoFormat(startDate)
                let end = DateFormatterHelper.shared.convertToIsoFormat(endDate)
                let newRule = PriceRuleRequest(priceRule: PriceRule(title: name, valueType: selectedValueType.type, value: "-\(discountValue)", oncePerCustomer: oncePerCustomer, startsAt: start, endsAt: end))
                
                addPriceRuleAction(newRule)
                dismiss()
            }.padding(.bottom, 50)
            
        }.padding()
    }
}



enum ValueType: String, CaseIterable {
    case percentage = "Percentage"
    case fixed = "Fixed Amount"
    
    var type: String {
        switch self {
        case .percentage:
            return "percentage"
        case .fixed:
            return "fixed_amount"
        }
    }
}

#Preview {
    AddPriceRuleView(){_ in
        
    }
}
