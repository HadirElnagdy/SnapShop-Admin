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
        VStack(spacing: 8) {
            collectionImageView
            Text(collectionName)
                .font(.headline)
        }.padding([.leading, .trailing], 8)
    }
    
    
    private var collectionImageView: some View {
        ZStack(alignment: .topTrailing) {
            AppImageView(imageURL: collectionImageURL)
            deleteButton
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 5)
        )
    }
    
    private var deleteButton: some View {
        Button (action: deleteAction) {
            Image(systemName: "minus.circle.fill")
                .font(.title2)
                .padding()
        }
    }
}

#Preview {
    CollectionsCustomCell(collectionName: "Nike", collectionImageURL: "https://cdn.shopify.com/s/files/1/0665/3709/5347/collections/52e93c3a86b9b62e023e5977ab218302.png?v=1716294342", deleteAction: {})
}
