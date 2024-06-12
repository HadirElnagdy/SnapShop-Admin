//
//  ProductsGrid.swift
//  SnapShop-Admin
//
//  Created by Hadir on 27/05/2024.
//

import SwiftUI

struct ProductsGrid: View {
    
    var screenHeight: Double
    var productsList: [Product]
    var deleteProduct: (Product) -> Void

    var body: some View {
        GridView(items: productsList, columns: 2) { product in
            NavigationLink(destination: AddProductView(product: product)){
            ProductsCustomCell(productImageURL: product.image?.src ?? "",
                               productName: product.title ?? "",
                               productCategory: product.productType ?? "",
                               productPrice: "\(product.variants?.first?.price ?? "") USD"){
                deleteProduct(product)
            }.frame(height: screenHeight*0.42)
        }
        }
    }
}




