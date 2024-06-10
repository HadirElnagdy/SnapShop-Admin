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
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let cellWidth = screenWidth * 0.9
            let imageSide = cellWidth * 0.9
            let padding = (screenWidth - cellWidth) / 2
            
            VStack(spacing: 8) {
                CellImageView(imageURL: productImageURL, imageSide: imageSide, deleteAction: deleteAction)
                    .frame(width: cellWidth, height: cellWidth)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                productInfoView
            }
            .padding(.horizontal, padding)
            .padding(.vertical, 10)
            .cornerRadius(10)
        }
    }
    
    private var productInfoView: some View {
        VStack{
            Text(extractSecondPart(from: productName) ?? "")
                .font(.callout)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
            
            Text(productCategory)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
            
            Text(productPrice)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 5)
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
