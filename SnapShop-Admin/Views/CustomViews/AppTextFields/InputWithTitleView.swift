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
    @State private var fieldModel: FieldModel
    
    init(title: String, placeholder: String, text: Binding<String>) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self._fieldModel = State(initialValue: FieldModel(value: text.wrappedValue, fieldType: .basic(placeholder: placeholder)))
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
            AppTextField(fieldModel: $fieldModel)
        }
    }
}

