//
//  AddCollectionView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct AddCollectionView: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Environment(\.dismiss) var dismiss
    var collection: Collection? = nil
    
    var body: some View {
        
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let imageSide = screenWidth * 0.9
            
            VStack {
                AppImageView(imageURL: collectionsViewModel.collectionImageURL, imageSide: imageSide)
                
                InputWithTitleView(title: "Collection Name", placeholder: "Name", text: $collectionsViewModel.collectionName)
                
                InputWithTitleView(title: "Image URL", placeholder: "Image", text: $collectionsViewModel.collectionImageURL)
                Spacer()
                AppButton(text: collection == nil ? "Add Collection" : "Update Collection", width: 350, height: 50, isFilled: true) {
                    if collection == nil {
                        collectionsViewModel.createCollection()
                    } else {
                        let updatedCollection = CollectionRequest(collection: Collection(id: collection?.id, title: collectionsViewModel.collectionName, image: CollectionImage(src: collectionsViewModel.collectionImageURL)))
                        collectionsViewModel.updateCollection(collection: updatedCollection)
                    }
                    dismiss()
                }.padding(.bottom, 50)
            }
            .padding()
            .onAppear {
                if let collection = collection {
                    collectionsViewModel.collectionName = collection.title ?? ""
                    collectionsViewModel.collectionImageURL = collection.image?.src ?? ""
                }
            }
            .onDisappear {
                collectionsViewModel.clearFields()
            }
        }
    }
}

#Preview {
    AddCollectionView(collectionsViewModel: CollectionsViewModel())
}
