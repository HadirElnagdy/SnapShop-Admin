//
//  CollectionsGrid.swift
//  SnapShop-Admin
//
//  Created by Hadir on 30/05/2024.
//

import SwiftUI

struct CollectionsGrid: View {
    
    var screenHeight: Double
    var collections: [Collection]
    var deleteCollection: (Collection) -> Void
    var viewModel: CollectionsViewModel
    
    var body: some View {
        GridView(items: collections, columns: 2) { collection in
            NavigationLink(destination: AddCollectionView(collectionsViewModel: viewModel, collection: collection)) {
                CollectionsCustomCell(collectionName: collection.title!, collectionImageURL: collection.image?.src){
                    deleteCollection(collection)
                        
                }.frame(height: screenHeight * 0.31)
                    .padding()
                    
            }
        }
        .padding(.leading)
    }
}


