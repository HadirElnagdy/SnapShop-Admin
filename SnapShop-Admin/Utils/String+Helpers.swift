//
//  String + Helpers.swift
//  SnapShop-Admin
//
//  Created by Hadir on 13/06/2024.
//

import Foundation

import Foundation

extension String {
    func extractBrandAndTitle() -> (brand: String?, title: String?) {
        let components = self.split(separator: "|").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        let brand = components.indices.contains(0) ? components[0] : nil
        let title = components.indices.contains(1) ? components[1] : nil
        return (brand, title)
    }
}
