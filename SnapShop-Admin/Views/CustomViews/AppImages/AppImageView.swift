//
//  AppImageView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct AppImageView: View {
    var imageURL: String?

    var body: some View {
        Group {
            if let url = imageURL, let validURL = URL(string: url) {
                AsyncImage(url: validURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding()
                    case .failure:
                        placeholderImage
                    @unknown default:
                        placeholderImage
                    }
                }
            } else {
                placeholderImage
            }
        }
    }

    private var placeholderImage: some View {
        Image("imgPlaceholder")
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    AppImageView(imageURL: nil)
        .previewLayout(.sizeThatFits)
                    .padding()
}
