//
//  ProductsGrid.swift
//  SnapShop-Admin
//
//  Created by Hadir on 27/05/2024.
//

import SwiftUI

struct ProductsGrid: View {
    var productsList: [Product]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(productsList, id: \.id) { product in
                ProductsCustomCell(productImageURL: product.image?.src ?? "",
                                   productName: product.title ?? "",
                                   productCategory: product.productType ?? "",
                                   productPrice: "\(product.variants?.first?.price ?? "") EGP")
            }
        }
        .padding()
    }
}

