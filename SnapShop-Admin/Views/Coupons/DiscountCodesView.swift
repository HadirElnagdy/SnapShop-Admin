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
    var body: some View {
        List(viewModel.discountCodes) { codeDetails in
            Text(codeDetails.code)
        }
        .onAppear{
            viewModel.getDiscountCodes(ruleId: ruleId)
        }
    }
}

#Preview {
    DiscountCodesView(ruleId: "1119217582259")
}
