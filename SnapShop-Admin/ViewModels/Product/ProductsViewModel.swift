//
//  ProductsViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 02/06/2024.
//

import Foundation

class ProductsViewModel: ObservableObject {
    
    @Published var productList = [Product]()
    
    func getProducts() {
        print("Fetching data...")
        APIClient.getAllProducts{[weak self] result in
            switch result {
            case .success(let success):
                self?.productList = success.products ?? []
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
