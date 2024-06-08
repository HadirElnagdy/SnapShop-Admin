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
    
    func deleteProduct(product: Product){
        if let index = productList.firstIndex(where: { $0.id == product.id }) {
                    productList.remove(at: index)
                }
        APIClient.deleteProduct(productId: "\(product.id ?? 0)") { result in
            switch result {
            case .success(_):
                print("Product Deleted Successfully!")
            case .failure(let error):
                print("Failed to delete product: \(error.localizedDescription)")
            }
        }
    }
    
}
