//
//  ProductsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct ProductsView: View {
    
    var productsList: [ProductsResponse]
    @State var openAddProductView: Bool = false
    @State var searchQuery = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //Search bar goes here
                ProductsGrid(productsList: productsList)
            }
            .navigationBarTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        openAddProductView.toggle()
                    } label: {
                        Image(systemName: "plus.app")
                            .font(.system(size: 24))
                    }
                    .sheet(isPresented: $openAddProductView, content: {
                        AddProductView()
                    })
                }
            }
        }
    }
}


#Preview {
    ProductsView(productsList: [
        ProductsResponse(title: "ADIDAS | CLASSIC BACKPACK | LEGEND INK MULTICOLOUR",
                         productType: "ACCESSORIES",
                         description: nil,
                         id: "gid://shopify/Product/7882327785651",
                         priceRangeV2: PriceRangeV2(amount: "50.0", currencyCode: "EGP"),
                         featuredImage: "https://cdn.shopify.com/s/files/1/0665/3709/5347/files/8072c8b5718306d4be25aac21836ce16_bbb5f91f-a37a-4b27-aacf-a87bf676f36d.jpg?v=1716294860"),
        
        ProductsResponse(title: "ADIDASOO | CLASSIC BACKPACK",
                         productType: "ACCESSORIES",
                         description: nil,
                         id: "gid://shopify/Product/7882327752883",
                         priceRangeV2: PriceRangeV2(amount: "70.0", currencyCode: "EGP"),
                         featuredImage: "https://cdn.shopify.com/s/files/1/0665/3709/5347/files/85cc58608bf138a50036bcfe86a3a362_92d9af79-6a32-4653-93d7-704e5215c9b9.jpg?v=1716294856"),
        
        ProductsResponse(title: "NIKE | SWOOSH PRO FLAT PEAK CAP",
                         productType: "ACCESSORIES",
                         description: nil,
                         id: "gid://shopify/Product/7882327687347",
                         priceRangeV2: PriceRangeV2(amount: "30.0", currencyCode: "EGP"),
                         featuredImage: "https://cdn.shopify.com/s/files/1/0665/3709/5347/files/58262e66c5e9731050280eb16880d5a4_42cfd075-4bb3-4ae2-ad8e-bb68eaa00455.jpg?v=1716294853"),
        
        ProductsResponse(title: "FLEX FIT | MINI OTTOMAN BLACK",
                         productType: "ACCESSORIES",
                         description: nil,
                         id: "gid://shopify/Product/7882327621811",
                         priceRangeV2: PriceRangeV2(amount: "29.99", currencyCode: "EGP"),
                         featuredImage: "https://cdn.shopify.com/s/files/1/0665/3709/5347/files/6170fd62b8ebee856d0cbdeac874abfd_d99819cd-458e-44bf-a514-b1c1044d4b4e.jpg?v=1716294848")
    ])
}


