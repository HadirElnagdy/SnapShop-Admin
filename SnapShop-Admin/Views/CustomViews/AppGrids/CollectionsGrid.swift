//
//  CollectionsGrid.swift
//  SnapShop-Admin
//
//  Created by Hadir on 30/05/2024.
//

import SwiftUI

struct CollectionsGrid: View {
    
    var collections: [Collection]
    
    var body: some View {
        GridView(items: collections, columns: 2) { collection in
            CollectionsCustomCell(collectionName: collection.title!, collectionImageURL: collection.image?.src)
        }
    }
}

//#Preview {
//    CollectionsGrid()
//}
