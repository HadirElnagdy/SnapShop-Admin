//
//  AddCollectionView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct AddCollectionView: View {
    
    @ObservedObject var collectionsViewModel = CollectionsViewModel()
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack {
            AppImageView(imageURL: collectionsViewModel.collectionImageURL)
            InputWithTitleView(title: "Collection Name", placeholder: "Name", text: $collectionsViewModel.collectionName)
            
            InputWithTitleView(title: "Image URL", placeholder: "Image", text: $collectionsViewModel.collectionImageURL)
            
            
            AppButton(text: "Add Collection", width: 350, height: 50, isFilled: true) {
                collectionsViewModel.createCollection()
                dismiss()
            }.padding(.bottom, 50)
        }.padding()
    }
}

#Preview {
    AddCollectionView()
}

