//
//  ProductsCustomCell.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct ProductsCustomCell: View {
    
    var productImageURL: String?
    let productName: String
    let productCategory: String
    let productPrice: String
    var deleteAction: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            productImageView
            productInfoView
        }.padding([.leading, .trailing], 8)
            
        
    }
    
    private var productImageView: some View {
        ZStack(alignment: .topTrailing) {
            AppImageView(imageURL: productImageURL)
            deleteButton
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 5)
        )
    }
    
    private var deleteButton: some View {
        Button (action: deleteAction) {
            Image(systemName: "minus.circle.fill")
                .font(.title2)
                .padding()
        }
    }
    
    private var productInfoView: some View {
        VStack(alignment: .center) {
            Text(extractSecondPart(from: productName) ?? "")
                .font(.callout)
                .lineLimit(1)
            
            Text(productCategory)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(productPrice)
                .font(.headline)
        }
    }
    
    func extractSecondPart(from title: String) -> String? {
        let components = title.split(separator: "|").map { $0.trimmingCharacters(in: .whitespaces) }
        guard components.count > 1 else { return nil }
        return components[1]
    }
}

#Preview {
    ProductsCustomCell(
        productImageURL: "https://cdn.shopify.com/s/files/1/0665/3709/5347/files/85cc58608bf138a50036bcfe86a3a362_92d9af79-6a32-4653-93d7-704e5215c9b9.jpg?v=1716294856",
        productName: "ADIDAS | CLASSIC BACKPACK | LEGEND INK MULTICOLOUR",
        productCategory: "ACCESSORIES",
        productPrice: "50.0 EGP",
        deleteAction: {}
    )
}
