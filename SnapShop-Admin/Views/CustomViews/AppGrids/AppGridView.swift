//
//  GridView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct GridView<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var columns: Int
    var content: (Item) -> ItemView

    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.flexible()), count: columns)
        
        LazyVGrid(columns: gridItems) {
            ForEach(items) { item in
                content(item)
                    
            }
        }
        .padding()
    }
}

