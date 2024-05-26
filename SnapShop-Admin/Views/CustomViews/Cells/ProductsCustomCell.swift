//
//  ProductsCustomCell.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct ProductsCustomCell: View {
    
    var productImage: Image = Image(.imgPlaceholder)
    let productName: String
    let productCategory: String
    let productPrice: String
    
    var body: some View {
        VStack(spacing: 8) {
            productImageView
            productInfoView
        }
        .padding()
    }
    
    
    private var productImageView: some View {
        ZStack(alignment: .topTrailing) {
            productImage
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 24.0))
            
            deleteButton
        }
    }
    
    
    private var deleteButton: some View {
        Button {
            // Deleting action here
        } label: {
            Image(systemName: "minus.circle.fill")
                .font(.title2)
                .padding()
        }
        .padding([.top, .trailing], 8)
    }
    
    
    private var productInfoView: some View {
        VStack(alignment: .center) {
            Text(productName)
                .font(.title2)
            
            Text(productCategory)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(productPrice)
                .font(.headline)
        }
    }
}

#Preview {
    ProductsCustomCell(productName: "CLASSIC BACKPACK", productCategory: "ACCESSORIES", productPrice: "300.0 USD")
}


