//
//  ContentView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 22/05/2024.
//

import SwiftUI
struct ContentView: View {
    
    @State var selectedTab: Tab = .products
    @ObservedObject var appCommon = AppCommon.shared
    @ObservedObject var networkMonitor = NetworkMonitor()
    @State private var showSplash = true

    var body: some View {
        
        ZStack{
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5))
            }else{
                if networkMonitor.isConnected {
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
                }else{
                    NetworkUnavailableView()
                }
            }
        }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                    withAnimation {
                        showSplash = false
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}


