//
//  CustomTabBarView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack (alignment: .center){
            tabBarItem(for: .products)
            tabBarItem(for: .collections)
            tabBarItem(for: .coupons)
           
        }.frame(height: 82 )
            .ignoresSafeArea(edges: .bottom)
            .tint(AppColors.primaryColor)
    }
    
    private func tabBarItem(for tab: Tab) -> some View {
        return Button {
            selectedTab = tab
        } label: {
            TabBarButton(tabTitle: tab.title, tabIcon: tab.imageName, isSelected: selectedTab == tab)
        }
        .tint(AppColors.primaryColor)
    }
}


#Preview {
    CustomTabBarView(selectedTab: .constant(.products))
}



