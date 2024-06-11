//
//  AddProductView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct AddProductView: View {
    
    @ObservedObject var productsViewModel = ProductsViewModel()
    @ObservedObject var collectionsViewModel = CollectionsViewModel()
    @Environment(\.dismiss) var dismiss
    var product: Product? = nil
    @State private var productName: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var availableQuantity  = ""
    @State private var selectedProductType: ProductType = .accessories
    @State private var tags = ""
    @State private var newImageURL: String = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    AppImageView(imageURL: productsViewModel.imageURLs.first, imageSide: geo.size.width * 0.92)
                    InputWithTitleView(title: "Name", placeholder: "Product Name", text: $productName)
                    Text("Description")
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    InputWithTitleView(title: "Price", placeholder: "300", text: $price)
                    InputWithTitleView(title: "Available Quantity", placeholder: "30", text: $availableQuantity)
                    
                    HStack {
                        Text("Collection: ")
                        Picker("Select a collection", selection: $productsViewModel.selectedCollection) {
                            ForEach(collectionsViewModel.collections, id: \.title) { collection in
                                Text(collection.title ?? "")
                                    .tag(collection.title ?? "")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Text("Product Type: ")
                        Picker("Product Type", selection: $selectedProductType) {
                            ForEach(ProductType.allCases, id: \.self) { productType in
                                Text(productType.rawValue).tag(productType)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    InputWithTitleView(title: "Tags", placeholder: "Classic, backpack", text: $tags)
                    Text("Image URL")
                    HStack {
                        TextField("Image URL", text: $newImageURL)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1.5)
                            )
                            .padding(.bottom, 10)
                        Button {
                            guard !newImageURL.isEmpty else { return }
                            productsViewModel.imageURLs.append(newImageURL)
                            newImageURL = ""
                        } label: {
                            Image(systemName: "plus")
                                .font(.title3)
                        }
                    }
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(productsViewModel.imageURLs, id: \.self) { imageURL in
                            CellImageView(imageURL: imageURL, imageSide: geo.size.width * 0.3 , deleteAction: {
                                if let index = productsViewModel.imageURLs.firstIndex(of: imageURL) {
                                    productsViewModel.imageURLs.remove(at: index)
                                }
                            })
                        }
                    }
                    
                    AppButton(text: product == nil ? "Add Product" : "Update Product", width: geo.size.width * 0.9, height: geo.size.height * 0.06, isFilled: true) {
                        let productId = product == nil ? nil : product?.id
                        let productImages = productsViewModel.imageURLs.map { ProductImage(src: $0) }
                        let productRequest = ProductRequest(product: Product(id: productId,
                            title: "\(productsViewModel.selectedCollection) | \(productName) | ",
                            description: description,
                            vendor: productsViewModel.selectedCollection,
                            productType: selectedProductType.rawValue,
                            tags: tags,
                            variants: [Variant(price: "\(price) EGP", inventoryQuantity: Int(availableQuantity))],
                            images: productImages
                        ))
                        if product == nil {
                            productsViewModel.createProduct(product: productRequest)
                        }else{
                            productsViewModel.updateProduct(product: productRequest)
                        }
                        dismiss()
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
            .onAppear {
                collectionsViewModel.getCollections()
                productsViewModel.imageURLs = []
                if let firstCollection = collectionsViewModel.collections.first?.title {
                    productsViewModel.selectedCollection = firstCollection
                } else {
                    productsViewModel.selectedCollection = "Loading..."
                }
                
                if let product = product {
                    productName = extractBrandAndTitle(from: product.title).title ?? ""
                    description = product.description ?? ""
                    price = product.variants?.first?.price ?? ""
                    availableQuantity = "\(product.variants?.first?.inventoryQuantity ?? 0)"
                    selectedProductType = ProductType(rawValue: product.productType ?? "") ?? .accessories
                    tags = product.tags ?? ""
                    productsViewModel.selectedCollection = extractBrandAndTitle(from: product.title).brand ?? ""
                    if let images = product.images {
                        productsViewModel.imageURLs = images.map { $0.src ?? "" }
                    }
                }
            }
        }
    }
    
    func extractBrandAndTitle(from string: String?) -> (brand: String?, title: String?) {
        let components = string?.split(separator: "|").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        let brand = ((components?.indices.contains(0)) != nil) ? components?[0] : nil
        let title = ((components?.indices.contains(1)) != nil) ? components?[1] : nil
        
        return (brand, title)
    }
}


#Preview {
    AddProductView(productsViewModel: ProductsViewModel())
}
