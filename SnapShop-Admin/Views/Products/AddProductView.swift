//
//  AddProductView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct AddProductView: View {
    
    @ObservedObject var productsViewModel = ProductsViewModel()
    @Environment(\.dismiss) var dismiss
    var product: Product? = nil
    @State private var productName: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var availableQuantity  = ""
    @State private var selectedProductType: ProductType = .accessories
    @State private var tags = ""
    @State private var selectedCollection = ""
    @State private var newImageURL: String = ""
    @State private var isValid = true
    @State private var showAlert = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    AppImageView(imageURL: productsViewModel.imageURLs.first, imageSide: geo.size.width * 0.92)
                    InputWithTitleView(title: "Name", placeholder: "Product Name", text: $productName)
                    TextEditorWithTitle(title: "Description", text: $description)
                    InputWithTitleView(title: "Price $", placeholder: "Price in dollar", text: $price)
                        .keyboardType(.decimalPad) // Allowing decimal numbers for price
                    InputWithTitleView(title: "Available Quantity", placeholder: "30", text: $availableQuantity)
                        .keyboardType(.numberPad)
                    InputWithTitleView(title: "Collection", placeholder: "ADIDAS", text: $selectedCollection)
                    ProductsPickerView(selection: $selectedProductType)
                    InputWithTitleView(title: "Tags", placeholder: "Classic, backpack", text: $tags)
                    
                    ImageURLInputView(newImageURL: $newImageURL, imageURLs: $productsViewModel.imageURLs)
                    
                    ImageGridView(imageURLs: $productsViewModel.imageURLs, geo: geo)
                    
                    AppButton(text: product == nil ? "Add Product" : "Update Product", width: geo.size.width * 0.9, height: geo.size.height * 0.06, isFilled: true) {
                        if validateFields() {
                            saveProduct()
                            dismiss()
                        } else {
                            showAlert = true
                        }
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Validation Error"),
                    message: Text("Please fill in all fields correctly. Price and quantity must be greater than zero."),
                    dismissButton: .default(Text("OK")) {
                        showAlert = false
                    }
                )
            }
            .onAppear {
                setupView()
            }
        }
    }
    
    private func setupView() {
        productsViewModel.imageURLs = []
        if let product = product {
            populateFields(with: product)
        }
    }
    
    private func populateFields(with product: Product) {
        productName = product.title?.extractBrandAndTitle().title ?? ""
        description = product.description ?? ""
        price = product.variants?.first?.price ?? ""
        availableQuantity = "\(product.variants?.first?.inventoryQuantity ?? 0)"
        selectedProductType = ProductType(rawValue: product.productType ?? "") ?? .accessories
        tags = product.tags ?? ""
        selectedCollection = product.title?.extractBrandAndTitle().brand ?? ""
        if let images = product.images {
            productsViewModel.imageURLs = images.map { $0.src ?? "" }
        }
    }
    
    private func saveProduct() {
        let productId = product?.id
        let productImages = productsViewModel.imageURLs.map { ProductImage(src: $0) }
        let productRequest = ProductRequest(product: Product(id: productId,
                                                             title: "\(selectedCollection.uppercased()) | \(productName) | ",
                                                             description: description,
                                                             vendor: selectedCollection.uppercased(),
                                                             productType: selectedProductType.rawValue,
                                                             tags: tags,
                                                             variants: [Variant(price: price, inventoryQuantity: Int(availableQuantity) ?? 0)],
                                                             images: productImages
                                                            ))
        if product == nil {
            productsViewModel.createProduct(product: productRequest)
        } else {
            productsViewModel.updateProduct(product: productRequest)
        }
    }
    
    private func validateFields() -> Bool {
        guard !productName.isEmpty,
              !price.isEmpty,
              !availableQuantity.isEmpty,
              !selectedCollection.isEmpty,
              !tags.isEmpty,
              let priceValue = Double(price),
              let quantityValue = Int(availableQuantity),
              priceValue > 0,
              quantityValue > 0 else {
            return false
        }
        return true
    }
}



struct TextEditorWithTitle: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
            TextEditor(text: $text)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}

struct ImageGridView: View {
    @Binding var imageURLs: [String]
    let geo: GeometryProxy
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ForEach(imageURLs, id: \.self) { imageURL in
                CellImageView(imageURL: imageURL, imageSide: geo.size.width * 0.3, deleteAction: {
                    if let index = imageURLs.firstIndex(of: imageURL) {
                        imageURLs.remove(at: index)
                    }
                })
            }
        }
    }
}

struct ImageURLInputView: View {
    @Binding var newImageURL: String
    @Binding var imageURLs: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Image URL")
            HStack {
                TextField("Image URL", text: $newImageURL)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1.5)
                    )
                Button(action: addImageURL) {
                    Image(systemName: "plus")
                        .font(.title3)
                }
            }
        }
        .padding(.bottom, 10)
    }
    
    private func addImageURL() {
        guard !newImageURL.isEmpty else { return }
        imageURLs.append(newImageURL)
        newImageURL = ""
    }
}

struct ProductsPickerView: View {
    
    
    @Binding var selection: ProductType

    var body: some View {
        HStack(spacing: 10) {
            Text("Product Type")
            Picker("Product Type", selection: $selection) {
                ForEach(ProductType.allCases, id: \.self) { type in
                    Text("\(type.rawValue)")
                        .tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Spacer()
        }
    }
}

#Preview {
    AddProductView(productsViewModel: ProductsViewModel())
}
