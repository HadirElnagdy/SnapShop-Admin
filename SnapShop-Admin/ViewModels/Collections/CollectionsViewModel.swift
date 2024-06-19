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
    @Published var userError: NetworkError? = nil
    @Published var collectionToDelete: Collection? = nil
    
    var apiClient: APIClientType.Type
    
    init(apiClient: APIClientType.Type = APIClient.self) {
        self.apiClient = apiClient
    }
    
    func createCollection() {
        let collection = CollectionRequest(collection: Collection(title: collectionName.uppercased(), image: CollectionImage(src: collectionImageURL)))
        apiClient.createCollection(collection: collection) { [weak self] result in
            switch result {
            case .success(let createdCollection):
                self?.userError = nil
                self?.collections.append(createdCollection.collection)
                print("Collection created: \(createdCollection.collection)")
            case .failure(let error):
                self?.userError = error
                print("Failed to create collection: \(error.localizedDescription)")
            }
        }
    }
    
    func getCollections() {
        print("Fetching collections...")
        apiClient.getAllCollections { [weak self] result in
            switch result {
            case .success(let success):
                self?.userError = nil
                self?.isLoading = false
                self?.collections = success.collections ?? []
            case .failure(let failure):
                self?.userError = failure
                self?.isLoading = false
                print(failure.localizedDescription)
            }
        }
    }
    
    func updateCollection(collection: CollectionRequest) {
        apiClient.updateCollection(collection: collection) { [weak self] result in
            switch result {
            case .success(let updatedCollection):
                self?.userError = nil
                self?.getCollections()
                print("Collection updated: \(updatedCollection.collection)")
            case .failure(let error):
                self?.userError = error
                print("Failed to update collection: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCollection(collection: Collection) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            collections.remove(at: index)
        }
        apiClient.deleteCollection(collectionId: "\(collection.id ?? 0)") {[weak self] result in
            switch result {
            case .success:
                self?.userError = nil
                print("Collection Deleted Successfully!")
            case .failure(let error):
                self?.userError = error
                print("Failed to delete collection: \(error.localizedDescription)")
            }
        }
    }
    
    func clearFields() {
        collectionName = ""
        collectionImageURL = ""
    }
    
}
