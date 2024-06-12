//
//  PriceRuleCell.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct PriceRuleCell: View {
    
    let priceRule: PriceRule
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                Text(priceRule.title ?? "Rule...")
                    .font(.headline)
                HStack {
                    Text("Discount: \(priceRule.value!)%")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Start: \(DateFormatterHelper.shared.convertFromIsoFormat(priceRule.startsAt ?? "Not specified") ?? "Not specified")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("End: \(DateFormatterHelper.shared.convertFromIsoFormat(priceRule.endsAt ?? "Not specified") ?? "Not specified")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(16)
            .shadow(radius: 3)
            
            NavigationLink(destination: DiscountCodesView(ruleId: "\(priceRule.id!)")) {
                EmptyView()
            }
            .opacity(0)
            
        }
    }
    
    
}


//#Preview {
//    PriceRuleCell()
//}
