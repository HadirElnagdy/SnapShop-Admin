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
            Spacer()
            tabBarItem(for: .collections)
            Spacer()
            tabBarItem(for: .coupons)
           
        }.frame(height: 82 )
            .ignoresSafeArea(edges: .bottom)
            .tint(AppColors.primaryColor)
    }
    
    private func tabBarItem(for tab: Tab) -> some View {
        let builder = TabBarItemBuilder(for: tab)
            .setText(tab.title)
            .setImageName(tab.imageName)

        return Button {
            selectedTab = tab
        } label: {
            builder.build(isActive: selectedTab == tab)
        }
        .tint(AppColors.primaryColor)
    }
}
#Preview {
    CustomTabBarView(selectedTab: .constant(.products))
}



