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
    
}
