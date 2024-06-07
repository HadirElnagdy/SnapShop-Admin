//
//  DiscountCodes.swift
//  SnapShop-Admin
//
//  Created by Hadir on 06/06/2024.
//

import Foundation

struct DiscountCodesResponse: Codable {
    let discountCodes: [DiscountCode]?
    
    enum CodingKeys: String, CodingKey {
        case discountCodes = "discount_codes"
    }
}

struct DiscountCodesRequest: Codable {
    let discountCode: DiscountCode
    
    enum CodingKeys: String, CodingKey {
        case discountCode = "discount_code"
    }
}

struct DiscountCode: Codable {
    let id: Int?
    let priceRuleId: Int
    let code: String
    let usageCount: Int?
    let createdAt: Date?
    let updatedAt: Date?
    
    init(id: Int? = nil, priceRuleId: Int, code: String, usageCount: Int? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.priceRuleId = priceRuleId
        self.code = code
        self.usageCount = usageCount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    enum CodingKeys: String, CodingKey {
        case id
        case priceRuleId = "price_rule_id"
        case code
        case usageCount = "usage_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct DiscountCodeResponse: Codable {
    let discountCodes: [DiscountCode]
}
