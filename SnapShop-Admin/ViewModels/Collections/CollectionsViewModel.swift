//
//  CollectionsViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import Foundation

class CollectionsViewModel: ObservableObject {
    
    @Published var collections = [Collection]()
    @Published var isLoading = true
    @Published var collectionImageURL: String = ""
    @Published var collectionName: String = ""
    
    func createCollection() {
        let collection = CollectionRequest(collection: Collection(title: collectionName, image: CollectionImage(src: collectionImageURL)))
        APIClient.createCollection(collection: collection) { [weak self] result in
            switch result {
            case .success(let createdCollection):
                self?.collections.append(createdCollection.collection)
                print("Collection created: \(createdCollection.collection)")
            case .failure(let error):
                print("Failed to create collection: \(error.localizedDescription)")
            }
        }
    }
    
    func getCollections() {
        print("Fetching collections...")
        APIClient.getAllCollections { [weak self] result in
            switch result {
            case .success(let success):
                self?.isLoading = false
                self?.collections = success.collections ?? []
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func updateCollection(collection: CollectionRequest) {
        APIClient.updateCollection(collection: collection) { [weak self] result in
            switch result {
            case .success(let updatedCollection):
                self?.getCollections()
                print("Collection updated: \(updatedCollection.collection)")
            case .failure(let error):
                print("Failed to update collection: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCollection(collection: Collection) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            collections.remove(at: index)
        }
        APIClient.deleteCollection(collectionId: "\(collection.id ?? 0)") { result in
            switch result {
            case .success:
                print("Collection Deleted Successfully!")
            case .failure(let error):
                print("Failed to delete collection: \(error.localizedDescription)")
            }
        }
    }
    
    func clearFields() {
            collectionName = ""
            collectionImageURL = ""
        }
    
}
