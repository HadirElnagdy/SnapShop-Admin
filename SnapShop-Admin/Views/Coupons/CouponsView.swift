//
//  CouponsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct CouponsView: View {
    var body: some View {
        NavigationStack {
            
            VStack{
                //search bar
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                    
                }
                
            }
            .navigationBarTitle("Coupons")
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
    CouponsView()
}
