//
//  ProductsViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 02/06/2024.
//

import Foundation

class ProductsViewModel: ObservableObject {
    
    @Published var productList = [Product]()
    @Published var imageURLs: [String] = []
    @Published var featuredImage = ""
    @Published var isLoading = true
    @Published var userError: NetworkError? = nil
    
    var apiClient: APIClientType.Type
    
    init(apiClient: APIClientType.Type = APIClient.self) {
        self.apiClient = apiClient
        featuredImage = imageURLs.first ?? ""
    }
    
    func getProducts() {
        print("Fetching data...")
        apiClient.getAllProducts{[weak self] result in
            switch result {
            case .success(let success):
                self?.isLoading = false
                self?.userError = nil
                self?.productList = success.products ?? []
            case .failure(let failure):
                self?.isLoading = false
                self?.userError = failure
                print(failure.localizedDescription)
                
            }
        }
    }
    
    func createProduct(product: ProductRequest) {
        apiClient.createProduct(product: product) {[weak self] result in
                switch result {
                case .success(let createdProduct):
                    print("Product created: \(createdProduct.product)")
                    self?.productList.append(createdProduct.product)
                    self?.userError = nil
                case .failure(let error):
                    self?.userError = error
                    print("Failed to create product: \(error.localizedDescription)")
                }
            }
        }
    
    func updateProduct(product: ProductRequest) {
        apiClient.updateProduct(product: product) {[weak self] result in
            switch result {
            case .success(let updatedProduct):
                print("Product updated: \(updatedProduct.product)")
                self?.userError = nil
                self?.getProducts()
            case .failure(let error):
                self?.userError = error
                print("Failed to update product: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteProduct(product: Product){
        apiClient.deleteProduct(productId: "\(product.id ?? 0)") {[weak self] result in
            switch result {
            case .success(_):
                print("Product Deleted Successfully!")
                if let index = self?.productList.firstIndex(where: { $0.id == product.id }) {
                    self?.productList.remove(at: index)
                        }
                self?.userError = nil
            case .failure(let error):
                self?.userError = error
                print("Failed to delete product: \(error.localizedDescription)")
            }
        }
    }
    
}
