//
//  AddProductView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct AddProductView: View {
    
    @ObservedObject var productsViewModel: ProductsViewModel
    @ObservedObject var collectionsViewModel = CollectionsViewModel()
    @Environment(\.dismiss) var dismiss
    var product: Product? = nil
    @State private var productName: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var availableQuantity: String = ""
    @State private var selectedCollection: Collection?
    @State private var selectedProductType: ProductType = .accessories
    @State private var tags = ""
    @State private var newTag: String = ""
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
                        Picker("Select a collection", selection: $selectedCollection) {
                            ForEach(collectionsViewModel.collections, id: \.self) { collection in
                                Text(collection.title ?? "")
                                            .tag(collection)

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
                    
                    // Images Grid
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                        ForEach(productsViewModel.imageURLs, id: \.self) { imageURL in
                            CellImageView(imageURL: imageURL, imageSide: 100, deleteAction: {
                                if let index = productsViewModel.imageURLs.firstIndex(of: imageURL) {
                                    productsViewModel.imageURLs.remove(at: index)
                                }
                            })
                        }
                    }
                    
                    AppButton(text: "Add Product", width: geo.size.width * 0.9, height: geo.size.height * 0.06, isFilled: true) {
                        dismiss()
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }.onAppear {
                collectionsViewModel.getCollections()
            }
        }
    }
}

#Preview {
    AddProductView(productsViewModel: ProductsViewModel())
}
