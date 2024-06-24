//
//  InputWithTitleView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct InputWithTitleView: View {
    
    var title: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
            TextField(placeholder, text: Binding(
                get: { text },
                set: { newValue in
                    text = newValue.replacingOccurrences(of: "^\\s+", with: "", options: .regularExpression)
                }
            ))
                           .padding(10)
                           .overlay(
                               RoundedRectangle(cornerRadius: 5)
                                   .stroke(Color.gray, lineWidth: 1.5)
                           )
                           .padding(.bottom, 10)
        }
    }
}

