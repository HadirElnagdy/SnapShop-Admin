//
//  ContentUnavailableView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 15/06/2024.
//

import SwiftUI

struct ContentUnavailableView<Description: View>: View {
    var title: String
    var imageName: String
    var description: Description?

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .opacity(0.8)
            
            Text(title)
                .bold()
                .font(.title2)
            
            if let description = description {
                description
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}

extension ContentUnavailableView where Description == EmptyView {
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
        self.description = nil
    }
}

#Preview {
    ContentUnavailableView(
        title: "No Internet Connection",
        imageName: "wifi.exclamationmark",
        description: Text("Please check your connection and try again.")
    )
}
