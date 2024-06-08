//
//  ContentView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 22/05/2024.
//

import SwiftUI
struct ContentView: View {
    
    @State var selectedTab: Tab = .products
    
    
    var body: some View {
        VStack {
            switch selectedTab{
            case .products:
                ProductsView()
            case .collections:
                CollectionsView()
            case .priceRules:
                PriceRulesView()
          }
            Spacer()
            CustomTabBarView(selectedTab: $selectedTab)
            
        }.ignoresSafeArea(edges: .bottom)
        
    }
}

#Preview {
    ContentView()
}
