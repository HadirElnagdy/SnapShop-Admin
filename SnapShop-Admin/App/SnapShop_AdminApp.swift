//
//  SnapShop_AdminApp.swift
//  SnapShop-Admin
//
//  Created by Hadir on 22/05/2024.
//

import SwiftUI

@main
struct SnapShop_AdminApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .overlay(
                    NetworkStatusView()
                        .frame(height: 50)
                        .ignoresSafeArea(),
                    alignment: .bottom
                )
        }
    }
}
