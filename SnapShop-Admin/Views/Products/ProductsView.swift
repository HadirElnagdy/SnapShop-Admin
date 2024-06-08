//
//  ProductsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct ProductsView: View {
    
    
    @State var openAddProductView: Bool = false
    @State var searchQuery = ""
    @ObservedObject var productsViewModel = ProductsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //Search bar goes here
                ProductsGrid(productsList: productsViewModel.productList, deleteProduct: productsViewModel.deleteProduct)
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
                    .sheet(isPresented: $openAddProductView){
                        AddProductView()
                    }
                }
            }
            .onAppear{
                productsViewModel.getProducts()
            }
        }
    }
}





