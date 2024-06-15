//
//  CellImage.swift
//  SnapShop-Admin
//
//  Created by Hadir on 09/06/2024.
//

import SwiftUI

struct CellImageView: View {
    
    var imageURL: String?
    var imageSide: Double
    var deleteAction: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            AppImageView(imageURL: imageURL, imageSide: imageSide)
            deleteButton
                .unredacted()
        }
        .background(
            RoundedRectangle(cornerRadius: imageSide/8)
                .fill(Color.white)
                .shadow(radius: 2)
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
    CellImageView(imageURL: "https://img.lovepik.com/free-png/20210918/lovepik-shopping-cart-png-image_400246975_wh1200.png", imageSide: 500){
        
    }
}
