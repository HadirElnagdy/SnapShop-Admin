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
        List {
            ForEach(viewModel.discountCodes) { codeDetails in
                Text(codeDetails.code)
                
            }.onDelete(perform: { indexSet in
                //alert & delete
                viewModel.discountCodes.remove(atOffsets: indexSet)
            })
        }
        .onAppear{
            viewModel.getDiscountCodes(ruleId: ruleId)
        }
        
    }
}

#Preview {
    DiscountCodesView(ruleId: "1119217582259")
}
