//
//  TabBarItemBuilder.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct TabBarItemBuilder {
    private var tab: Tab
    private var text: String
    private var imageName: String
    init(for tab: Tab) {
        self.tab = tab
        self.text = ""
        self.imageName = ""
    }
    func setText(_ text: String) -> TabBarItemBuilder {
        var builder = self
        builder.text = text
        return builder
    }
    func setImageName(_ imageName: String) -> TabBarItemBuilder {
        var builder = self
        builder.imageName = imageName
        return builder
    }
    func build(isActive: Bool) -> some View {
        TabBarButton(buttonText: text, imageName: imageName, isActive: isActive)
    }
}
