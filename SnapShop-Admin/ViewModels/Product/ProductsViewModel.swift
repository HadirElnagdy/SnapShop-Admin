//
//  ProductsViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 02/06/2024.
//

import Foundation

class ProductsViewModel: ObservableObject {
    
    @Published var productList = [Product]()
    @Published var featuredImage = ""
    @Published var imageURLs: [String] = []
    @Published var selectedCollection = ""
    @Published var isLoading = true
    
    func getProducts() {
        print("Fetching data...")
        APIClient.getAllProducts{[weak self] result in
            switch result {
            case .success(let success):
                self?.isLoading = false
                self?.productList = success.products ?? []
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func createProduct(product: ProductRequest) {
            APIClient.createProduct(product: product) {[weak self] result in
                switch result {
                case .success(let createdProduct):
                    print("Product created: \(createdProduct.product)")
                    self?.productList.append(createdProduct.product)
                case .failure(let error):
                    print("Failed to create product: \(error.localizedDescription)")
                }
            }
        }
    
    func updateProduct(product: ProductRequest) {
        APIClient.updateProduct(product: product) {[weak self] result in
            switch result {
            case .success(let updatedProduct):
                print("Product updated: \(updatedProduct.product)")
                self?.getProducts()
            case .failure(let error):
                print("Failed to update product: \(error.localizedDescription)")
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
