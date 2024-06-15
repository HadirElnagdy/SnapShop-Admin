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
    @State private var isValid = true
    @State private var showAlert = false
    
    var body: some View {
        
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let imageSide = screenWidth * 0.9
            
            ScrollView {
                VStack {
                    AppImageView(imageURL: collectionsViewModel.collectionImageURL, imageSide: imageSide)
                    
                    InputWithTitleView(title: "Collection Name", placeholder: "Name", text: $collectionsViewModel.collectionName)
                    
                    InputWithTitleView(title: "Image URL", placeholder: "Image", text: $collectionsViewModel.collectionImageURL)
                    
                    AppButton(text: collection == nil ? "Add Collection" : "Update Collection", width: geometry.size.width * 0.9, height: geometry.size.height * 0.06, isFilled: true) {
                        if validateFields() {
                            if collection == nil {
                                collectionsViewModel.createCollection()
                            } else {
                                let updatedCollection = CollectionRequest(collection: Collection(id: collection?.id, title: collectionsViewModel.collectionName, image: CollectionImage(src: collectionsViewModel.collectionImageURL)))
                                collectionsViewModel.updateCollection(collection: updatedCollection)
                            }
                            dismiss()
                        } else {
                            showAlert = true
                        }
                    }
                    .padding(.bottom, 50)
                }
                .padding()
                .showAlert(for: $collectionsViewModel.userError)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Validation Error"),
                        message: Text("Please fill in all fields."),
                        dismissButton: .default(Text("OK")) {
                            showAlert = false
                        }
                    )
                }
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
    
    private func validateFields() -> Bool {
        guard !collectionsViewModel.collectionName.isEmpty,
              !collectionsViewModel.collectionImageURL.isEmpty else {
            return false
        }
        return true
    }
}


#Preview {
    AddCollectionView(collectionsViewModel: CollectionsViewModel())
}
