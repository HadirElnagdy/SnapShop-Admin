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
    
    var body: some View {
        VStack{
            AppImageView(imageURL: collectionImageURL)
            Text(collectionName)
                .font(.headline)
        }
    }
}

#Preview {
    CollectionsCustomCell(collectionName: "Nike", collectionImageURL: "https://cdn.shopify.com/s/files/1/0665/3709/5347/collections/52e93c3a86b9b62e023e5977ab218302.png?v=1716294342")
}
