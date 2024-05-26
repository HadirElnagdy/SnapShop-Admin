//
//  TabBarButton.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct TabBarButton: View {
    var buttonText: String
    var imageName: String
    var isActive: Bool
    var body: some View {
        GeometryReader{ geo in
            if isActive {
                Rectangle()
                    .foregroundColor(Color.black)
                    .frame(width: geo.size.width/2,height: 3)
                    .padding(.leading,geo.size.width/4)
            }
            VStack (alignment: .center, spacing: 4){
                Image("\(isActive ? imageName + "_fill" : imageName)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24,height: 24)
                Text("\(buttonText)")
            }.frame(width: geo.size.width,height: geo.size.height)
        }
    }
}

#Preview {
    TabBarButton(buttonText: "Products", imageName: "ic_products", isActive: true)
}
