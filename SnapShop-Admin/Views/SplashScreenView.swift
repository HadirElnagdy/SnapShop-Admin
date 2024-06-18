//
//  SplashScreenView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 18/06/2024.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            Image(.icLogo)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    SplashScreenView()
}
