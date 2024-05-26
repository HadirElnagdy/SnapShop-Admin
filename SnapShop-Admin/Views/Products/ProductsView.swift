//
//  ProductsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct ProductsView: View {
    var body: some View {
        NavigationStack {
            
            VStack{
                //search bar
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
//                    ProductsCustomCell(productImage: <#T##Image#>, productName: <#T##String#>, productCategory: <#T##String#>, productPrice: <#T##String#>)
                }
                
            }
            .navigationBarTitle("Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        
                    }label: {
                        Image(systemName: "plus.app")
                            .font(.system(size: 24))
                    }
                }
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    ProductsView()
}
