//
//  CollectionsViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import Foundation

class CollectionsViewModel: ObservableObject {
    
    @Published var collections = [Collection]()
    
    func getCollections() {
        print("Fetching data...")
        APIClient.getAllCollections { [weak self] result in
            switch result {
            case .success(let success):
                self?.collections = success.collections ?? []
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
