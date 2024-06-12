//
//  CustomLottieView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 12/06/2024.
//

import SwiftUI
import Lottie

struct LoadingLottieView: View {
    var body: some View {
        LottieView(animation: .named("ShoppingAnimation"))
            .playbackMode(.playing(.toProgress(1, loopMode: .autoReverse)))
            .animationSpeed(1.5)
    }
}

#Preview {
    LoadingLottieView()
}
