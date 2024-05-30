//
//  CollectionsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct CollectionsView: View {
    var body: some View {
        NavigationStack {
            
            VStack{
                
                //search bar
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                    
                }
                
            }
            .navigationBarTitle("Collections")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        //open add new collection
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
    CollectionsView()
}
