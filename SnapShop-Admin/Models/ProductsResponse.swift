//
//  ProductsResponse.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import Foundation

struct ProductsResponse: Codable, Identifiable {
    let title: String?
    let productType: String?
    let description, id: String?
    let priceRangeV2: PriceRangeV2?
    let featuredImage: String?
}

struct PriceRangeV2: Codable {
    let amount: String?
    let currencyCode: String?
}
