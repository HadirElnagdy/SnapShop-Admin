//
//  AppTextField.swift
//  SnapShop-Admin
//
//  Created by Abdullah Essam on 01/06/2024.
//

import SwiftUI

struct AppTextField: View {
    
    var fieldModel: Binding<FieldModel>
     
    var body: some View {
        VStack(alignment: .leading){
            TextField(fieldModel.fieldType.wrappedValue.placeHolder, text: fieldModel.value)
                      .padding(10)
                       .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(AppColors.strokeColor, lineWidth: 1.5)
                       ).padding(.bottom,10)
            if let error = fieldModel.error.wrappedValue{
                Text(error).foregroundStyle(Color.red).font(.system(size: 15)).multilineTextAlignment(.leading).padding([.horizontal],0)
            }
        }
    }
}


