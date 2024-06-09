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
            let imageSide = screenWidth * 0.9 * 0.9
            VStack(alignment: .center){
                CellImageView(imageURL: collectionImageURL, imageSide: imageSide, deleteAction: deleteAction)
                    .frame(width: screenWidth * 0.8, height: screenWidth * 0.8)
                Text(collectionName)
                    .font(.headline)
                
            }
            
            
        }
    }
    
}

#Preview {
    CollectionsCustomCell(collectionName: "Nike", collectionImageURL: "https://cdn.shopify.com/s/files/1/0665/3709/5347/collections/52e93c3a86b9b62e023e5977ab218302.png?v=1716294342", deleteAction: {})
}
