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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(productsList, id: \.id) { product in
                        ProductsCustomCell(productImageURL: product.featuredImage, productName: product.title ?? "", productCategory: product.productType ?? "", productPrice: "\(product.priceRangeV2?.amount ?? "") \(product.priceRangeV2?.currencyCode ?? "")")
                    }
                }
                .padding()
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
        ProductsResponse(title: "Classic Backpack",
                         productType: "Backpack",
                         description: "A timeless classic, perfect for everyday use.",
                         id: "1",
                         priceRangeV2: PriceRangeV2(amount: "89.99", currencyCode: "USD"),
                         featuredImage: "https://cdn.shopify.com/s/files/1/0665/3709/5347/files/7883dc186e15bf29dad696e1e989e914_efe14d46-75f9-4434-8568-457cc0367ea6.jpg?v=1716294835"),
        
        ProductsResponse(title: "Leather Messenger Bag",
                         productType: "Messenger Bag",
                         description: "Crafted from genuine leather, ideal for work or travel.",
                         id: "2",
                         priceRangeV2: PriceRangeV2(amount: "149.99", currencyCode: "USD"),
                         featuredImage: "https://cdn.shopify.com/s/files/1/0665/3709/5347/files/0ea90fb43c087d165cbf985098cc951e_0d510f14-13cf-4833-8755-0ba1cc3e4b68.jpg?v=1716294829"),
        
        ProductsResponse(title: "Sporty Sneakers",
                         productType: "Footwear",
                         description: "Stay active and comfortable with these stylish sneakers.",
                         id: "3",
                         priceRangeV2: PriceRangeV2(amount: "79.99", currencyCode: "USD"),
                         featuredImage: "sporty_sneakers.jpg"),
        
        ProductsResponse(title: "Vintage Sunglasses",
                         productType: "Accessories",
                         description: "Add a touch of retro charm to your look with these sunglasses.",
                         id: "4",
                         priceRangeV2: PriceRangeV2(amount: "59.99", currencyCode: "USD"),
                         featuredImage: "vintage_sunglasses.jpg"),
        
        ProductsResponse(title: "Smart Watch",
                         productType: "Electronics",
                         description: "Stay connected and track your fitness goals with this smart watch.",
                         id: "5",
                         priceRangeV2: PriceRangeV2(amount: "199.99", currencyCode: "USD"),
                         featuredImage: "smart_watch.jpg"),
        
        ProductsResponse(title: "Portable Bluetooth Speaker",
                         productType: "Electronics",
                         description: "Enjoy high-quality sound anywhere with this portable speaker.",
                         id: "6",
                         priceRangeV2: PriceRangeV2(amount: "129.99", currencyCode: "USD"),
                         featuredImage: "bluetooth_speaker.jpg")])
}
