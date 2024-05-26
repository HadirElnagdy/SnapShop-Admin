//
//  TabBarButton.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct TabBarButton: View {
    
    var tabTitle: String
    var tabIcon: String
    var isSelected: Bool
    
    var body: some View {
        GeometryReader{ geo in
            if isSelected {
                Rectangle()
                    .foregroundColor(Color.black)
                    .frame(width: geo.size.width/2, height: 3)
                    .padding(.leading, geo.size.width/4)
            }
            VStack (alignment: .center, spacing: 4){
                Image("\(tabIcon)\(isSelected ? "_fill" : "")")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("\(tabTitle)")
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

#Preview {
    TabBarButton(tabTitle: "Products", tabIcon: "ic_products", isSelected: true)
}
