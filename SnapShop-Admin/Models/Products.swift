//
//  ProductsResponse.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import Foundation

// MARK: - ProductsResponse
struct ProductsResponse: Codable {
    let products: [Product]?
}

// MARK: - ProductRequest
struct ProductRequest: Codable {
    let product: Product
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let vendor: String?
    let productType: String?
    let createdAt: String?
    let handle: String?
    let updatedAt: String?
    let publishedAt: String?
    let templateSuffix: String?
    let publishedScope: String?
    let tags: String?
    let status: String?
    let adminGraphqlAPIID: String?
    let variants: [Variant]?
    let options: [Option]?
    let images: [ProductImage]?
    let image: ProductImage?

    enum CodingKeys: String, CodingKey {
        case id, title
        case description = "body_html"
        case vendor
        case productType = "product_type"
        case createdAt = "created_at"
        case handle
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case templateSuffix = "template_suffix"
        case publishedScope = "published_scope"
        case tags, status
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case variants, options, images, image
    }

    init(
        id: Int? = nil,
        title: String? = nil,
        description: String? = nil,
        vendor: String? = nil,
        productType: String? = nil,
        createdAt: String? = nil,
        handle: String? = nil,
        updatedAt: String? = nil,
        publishedAt: String? = nil,
        templateSuffix: String? = nil,
        publishedScope: String? = nil,
        tags: String? = nil,
        status: String? = nil,
        adminGraphqlAPIID: String? = nil,
        variants: [Variant]? = nil,
        options: [Option]? = nil,
        images: [ProductImage]? = nil,
        image: ProductImage? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.vendor = vendor
        self.productType = productType
        self.createdAt = createdAt
        self.handle = handle
        self.updatedAt = updatedAt
        self.publishedAt = publishedAt
        self.templateSuffix = templateSuffix
        self.publishedScope = publishedScope
        self.tags = tags
        self.status = status
        self.adminGraphqlAPIID = adminGraphqlAPIID
        self.variants = variants
        self.options = options
        self.images = images
        self.image = image
    }
}

// MARK: - ProductImage
struct ProductImage: Codable {
    let id: Int?
    let alt: String?
    let position: Int?
    let productID: Int?
    let createdAt: String?
    let updatedAt: String?
    let adminGraphqlAPIID: String?
    let width: Int?
    let height: Int?
    let src: String?
    let variantIDS: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, alt, position
        case productID = "product_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case width, height, src
        case variantIDS = "variant_ids"
    }

    init(
        id: Int? = nil,
        alt: String? = nil,
        position: Int? = nil,
        productID: Int? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        adminGraphqlAPIID: String? = nil,
        width: Int? = nil,
        height: Int? = nil,
        src: String? = nil,
        variantIDS: [Int]? = nil
    ) {
        self.id = id
        self.alt = alt
        self.position = position
        self.productID = productID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.adminGraphqlAPIID = adminGraphqlAPIID
        self.width = width
        self.height = height
        self.src = src
        self.variantIDS = variantIDS
    }
}

// MARK: - Option
struct Option: Codable {
    let id: Int?
    let productID: Int?
    let name: String?
    let position: Int?
    let values: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case name, position, values
    }

    init(
        id: Int? = nil,
        productID: Int? = nil,
        name: String? = nil,
        position: Int? = nil,
        values: [String]? = nil
    ) {
        self.id = id
        self.productID = productID
        self.name = name
        self.position = position
        self.values = values
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int?
    let productID: Int?
    let title: String?
    let price: String?
    let sku: String?
    let position: Int?
    let inventoryPolicy: String?
    let compareAtPrice: String?
    let fulfillmentService: String?
    let inventoryManagement: String?
    let option1: String?
    let option2: String?
    let option3: String?
    let createdAt: String?
    let updatedAt: String?
    let taxable: Bool?
    let barcode: String?
    let grams: Int?
    let weight: Double?
    let weightUnit: String?
    let inventoryItemID: Int?
    let inventoryQuantity: Int?
    let oldInventoryQuantity: Int?
    let requiresShipping: Bool?
    let adminGraphqlAPIID: String?
    let imageID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case title, price, sku, position
        case inventoryPolicy = "inventory_policy"
        case compareAtPrice = "compare_at_price"
        case fulfillmentService = "fulfillment_service"
        case inventoryManagement = "inventory_management"
        case option1, option2, option3
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case taxable, barcode, grams, weight
        case weightUnit = "weight_unit"
        case inventoryItemID = "inventory_item_id"
        case inventoryQuantity = "inventory_quantity"
        case oldInventoryQuantity = "old_inventory_quantity"
        case requiresShipping = "requires_shipping"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case imageID = "image_id"
    }

    init(
        id: Int? = nil,
        productID: Int? = nil,
        title: String? = nil,
        price: String? = nil,
        sku: String? = nil,
        position: Int? = nil,
        inventoryPolicy: String? = nil,
        compareAtPrice: String? = nil,
        fulfillmentService: String? = nil,
        inventoryManagement: String? = nil,
        option1: String? = nil,
        option2: String? = nil,
        option3: String? = nil,
        createdAt: String? = nil,
        updatedAt: String? = nil,
        taxable: Bool? = nil,
        barcode: String? = nil,
        grams: Int? = nil,
        weight: Double? = nil,
        weightUnit: String? = nil,
        inventoryItemID: Int? = nil,
        inventoryQuantity: Int? = nil,
        oldInventoryQuantity: Int? = nil,
        requiresShipping: Bool? = nil,
        adminGraphqlAPIID: String? = nil,
        imageID: Int? = nil
    ) {
        self.id = id
        self.productID = productID
        self.title = title
        self.price = price
        self.sku = sku
        self.position = position
        self.inventoryPolicy = inventoryPolicy
        self.compareAtPrice = compareAtPrice
        self.fulfillmentService = fulfillmentService
        self.inventoryManagement = inventoryManagement
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.taxable = taxable
        self.barcode = barcode
        self.grams = grams
        self.weight = weight
        self.weightUnit = weightUnit
        self.inventoryItemID = inventoryItemID
        self.inventoryQuantity = inventoryQuantity
        self.oldInventoryQuantity = oldInventoryQuantity
        self.requiresShipping = requiresShipping
        self.adminGraphqlAPIID = adminGraphqlAPIID
        self.imageID = imageID
    }
}
