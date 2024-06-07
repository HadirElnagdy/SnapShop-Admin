//
//  InputWithTitleView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct InputWithTitleView: View {
    
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
            TextField(title, text: $text).padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(AppColors.strokeColor, lineWidth: 1.5)
                )
                .autocorrectionDisabled()
                .textCase(.none)
        }.padding()
    }
}

