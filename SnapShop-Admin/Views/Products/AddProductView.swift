//
//  AddProductView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 26/05/2024.
//

import SwiftUI

struct AddProductView: View {
    
    @ObservedObject var viewModel: ProductsViewModel
    @Environment(\.dismiss) var dismiss
    var product: Product? = nil
    
    var body: some View {
        
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let imageSide = screenWidth * 0.9
            
            VStack {
                
            }
        }
    }
}

#Preview {
    AddProductView(viewModel: ProductsViewModel())
}

