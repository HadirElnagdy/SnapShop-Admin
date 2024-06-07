//
//  AddCollectionView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct AddCollectionView: View {
    
    @State var collectionImageURL: String = ""
    @State var collectionName: String = ""
    
    var body: some View {
        VStack {
            AppImageView(imageURL: collectionImageURL)
                .padding()
            InputWithTitleView(title: "Collection Name", text: $collectionName)
            
            InputWithTitleView(title: "Image URL", text: $collectionImageURL)
            
            AppButton(text: "Add Collection", width: 350, height: 50, isFilled: true)
        }
    }
}

#Preview {
    AddCollectionView()
}

