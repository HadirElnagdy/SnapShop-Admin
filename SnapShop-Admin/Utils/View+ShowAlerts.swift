//
//  View+ShowAlerts.swift
//  SnapShop-Admin
//
//  Created by Hadir on 14/06/2024.
//

import Foundation
import SwiftUI

extension View {
    func showAlert(for error: Binding<NetworkError?>) -> some View {
        self.alert(isPresented: .constant(error.wrappedValue != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(error.wrappedValue?.message ?? ""),
                dismissButton: .default(Text("OK")) {
                    error.wrappedValue = nil
                }
            )
        }
    }
}

