//
//  AppImageView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 07/06/2024.
//

import SwiftUI

struct AppImageView: View {
    var imageURL: String?
    var imageSide: Double

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
                            .clipShape(RoundedRectangle(cornerRadius: imageSide/8))
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
        }.frame(width: imageSide, height: imageSide)
    }

    private var placeholderImage: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.8))
            .cornerRadius(imageSide/8)
            .overlay(
                Text("No Image")
                    .foregroundColor(.white)
                    .font(.headline)
            )
    }
}


#Preview {
    AppImageView(imageURL: nil, imageSide: 200.0)
        .previewLayout(.sizeThatFits)
                    .padding()
}
