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
    @State private var searchText = ""
    
    var filteredCollections: [Collection] {
        if searchText.isEmpty {
            return collectionsViewModel.collections
        } else {
            return collectionsViewModel.collections.filter { collection in
                collection.title!.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    SearchBar(text: $searchText)
                        .padding(.top, 10)
                    
                    if collectionsViewModel.isLoading {
                        LoadingLottieView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onAppear {
                                collectionsViewModel.getCollections()
                            }
                    } else {
                        ScrollView {
                            if filteredCollections.isEmpty {
                                VStack(alignment: .center) {
                                    Spacer()
                                    ContentUnavailableView(title: "No collections!", imageName: "rectangle.stack.badge.plus")
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    Spacer()
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height)
                            } else {
                                CollectionsGrid(screenHeight: geometry.size.height, collections: filteredCollections, deleteCollection: { collection in
                                    selectedCollection = collection
                                }, viewModel: collectionsViewModel)
                            }
                        }
                        .refreshable {
                            collectionsViewModel.getCollections()
                        }
                        .navigationBarTitle("Collections")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    openAddCollectionView.toggle()
                                } label: {
                                    Image(systemName: "plus.app")
                                        .font(.system(size: 24))
                                }
                                .sheet(isPresented: $openAddCollectionView) {
                                    AddCollectionView(collectionsViewModel: collectionsViewModel)
                                }
                            }
                        }
                        .alert(item: $selectedCollection) { collection in
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
            }
        }
    }
}

#Preview {
    CollectionsView()
}
