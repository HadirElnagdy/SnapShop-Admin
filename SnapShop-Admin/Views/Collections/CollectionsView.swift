//
//  CollectionsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct CollectionsView: View {
    
    @ObservedObject var collectionsViewModel = CollectionsViewModel()
    
    var body: some View {
        NavigationStack {
            
            ScrollView{
                
                //search bar
                
                CollectionsGrid(collections: collectionsViewModel.collections)
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
            }
                .onAppear{
                    collectionsViewModel.getCollections()
                }
        }
    }
}

#Preview {
    CollectionsView()
}
