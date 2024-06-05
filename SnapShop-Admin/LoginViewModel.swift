//
//  LoginViewModel.swift
//  SnapShop-Admin
//
//  Created by Abdullah Essam on 01/06/2024.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var emailField : FieldModel = FieldModel(value: "",  fieldType: .email)
    @Published var passwordField : FieldModel = FieldModel(value: "",  fieldType: .password)
    
    
}
