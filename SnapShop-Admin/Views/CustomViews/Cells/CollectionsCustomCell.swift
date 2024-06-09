//
//  CollectionsCustomCell.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct CollectionsCustomCell: View {
    
    let collectionName: String
    let collectionImageURL: String?
    var deleteAction: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let imageSide = screenWidth * 0.44
            let horizontalPadding = screenWidth * 0.04
            
            VStack(spacing: 8) {
                CellImageView(imageURL: collectionImageURL, imageSide: imageSide, deleteAction: deleteAction)
                Text(collectionName)
                    .font(.headline)
            }.padding([.leading, .trailing], 8)
        }
    }
    
}

#Preview {
    CollectionsCustomCell(collectionName: "Nike", collectionImageURL: "https://cdn.shopify.com/s/files/1/0665/3709/5347/collections/52e93c3a86b9b62e023e5977ab218302.png?v=1716294342", deleteAction: {})
}
