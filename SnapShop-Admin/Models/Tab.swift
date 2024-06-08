//
//  Tab.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import Foundation

enum Tab: Int {
    case products
    case collections
    case priceRules
    
    var title: String {
            switch self {
            case .products: return "Product"
            case .collections: return "Collections"
            case .priceRules: return "Price Rules"
            }
        }
    
        var imageName: String {
            switch self {
            case .products: return "ic_products"
            case .collections: return "ic_collections"
            case .priceRules: return "ic_coupons"
            }
        }
}
