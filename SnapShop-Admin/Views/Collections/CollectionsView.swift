//
//  CollectionsView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct CollectionsView: View {
    
    @ObservedObject var collectionsViewModel = CollectionsViewModel()
    @State var openAddCollectionView: Bool = false
    @State var selectedCollection: Collection? = nil
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                if collectionsViewModel.isLoading{
                    LoadingLottieView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear{
                            collectionsViewModel.getCollections()
                        }
                }else{
                    if collectionsViewModel.collections.isEmpty {
                        ContentUnavailableView(title: "No collections added yet!", imageName: "rectangle.stack.badge.plus")
                    }else{
                        ScrollView{
                            CollectionsGrid(screenHeight: geometry.size.height, collections: collectionsViewModel.collections, deleteCollection: { collection in
                                selectedCollection = collection
                            }, viewModel: collectionsViewModel)
                        }
                        .navigationBarTitle("Collections")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button{
                                    openAddCollectionView.toggle()
                                }label: {
                                    Image(systemName: "plus.app")
                                        .font(.system(size: 24))
                                }
                                .sheet(isPresented: $openAddCollectionView){
                                    AddCollectionView(collectionsViewModel: collectionsViewModel)
                                }
                                
                            }
                        }.alert(item: $selectedCollection) { collection in
                            Alert(
                                title: Text("Confirm Deletion"),
                                message: Text("Are you sure you want to delete this collection?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    collectionsViewModel.deleteCollection(collection: collection)
                                },
                                secondaryButton: .cancel(Text("Cancel"))
                            )
                        }
                        
                    }
                }
            }.showAlert(for: $collectionsViewModel.userError)
        }
    }
}

#Preview {
    CollectionsView()
}
