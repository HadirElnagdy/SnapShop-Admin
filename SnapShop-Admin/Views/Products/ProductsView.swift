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
    @ObservedObject var collectionsViewModel = CollectionsViewModel()
    @State var selectedProduct: Product? = nil
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    if productsViewModel.isLoading{
                        LoadingLottieView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }else{
                        ProductsGrid(screenHeight: geometry.size.height, productsList: productsViewModel.productList, deleteProduct: { product in
                            selectedProduct = product
                        })
                    }
                    
                }
                .refreshable {
                    productsViewModel.getProducts()
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
                            AddProductView(productsViewModel: productsViewModel)
                        }
                    }
                }
                .alert(item: $selectedProduct) { product in
                    Alert(
                        title: Text("Confirm Deletion"),
                        message: Text("Are you sure you want to delete this product?"),
                        primaryButton: .destructive(Text("Delete")) {
                            productsViewModel.deleteProduct(product: product)
                        },
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }
                .onAppear{
                    productsViewModel.getProducts()
                }
            }
        }
       
    }
}

#Preview {
    ProductsView()
}



