//
//  ProductsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct ProductsView: View {
    
    
    @State var openAddProductView: Bool = false
    @ObservedObject var productsViewModel = ProductsViewModel()
    @State var selectedProduct: Product? = nil
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    if productsViewModel.isLoading{
                        LoadingLottieView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }else{
                        if productsViewModel.productList.isEmpty {
                            VStack(alignment: .center) {
                                Spacer()
                                ContentUnavailableView(title: "No products!", imageName: "cart.badge.plus")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                Spacer()
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        } else {
                            ProductsGrid(screenHeight: geometry.size.height, productsList: productsViewModel.productList, deleteProduct: { product in
                                selectedProduct = product
                            })
                        }
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


