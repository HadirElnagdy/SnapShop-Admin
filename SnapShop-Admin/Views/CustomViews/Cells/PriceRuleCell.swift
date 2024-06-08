//
//  PriceRuleCell.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

import SwiftUI

struct PriceRuleCell: View {
    let priceRule: PriceRule
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(priceRule.title ?? "Rule...")
                .font(.headline)
            HStack {
                Text("Discount: \(priceRule.value!)%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Start: \(formatDate(priceRule.startsAt ?? "Not specified") ?? "Not specified")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("End: \(formatDate(priceRule.endsAt ?? "Not specified") ?? "Not specified")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
    
    private func formatDate(_ dateString: String?) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = inputFormatter.date(from: dateString ?? "") {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .short
            outputFormatter.timeStyle = .none
            return outputFormatter.string(from: date)
        }
        return dateString
    }
}


//#Preview {
//    PriceRuleCell()
//}
