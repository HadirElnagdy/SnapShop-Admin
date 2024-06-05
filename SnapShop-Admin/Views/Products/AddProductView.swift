//
//  AddProductView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct AddProductView: View {
    @State var productFeaturedImage = ""
    @State var productName = ""
    var body: some View {
        Form{
            Image(.imgPlaceholder)
                .resizable()
                .scaledToFit()
            
            Section("Product Details") {
                TextField("Product Name", text: $productName)
            }
        }
    }
}

#Preview {
    AddProductView()
}
