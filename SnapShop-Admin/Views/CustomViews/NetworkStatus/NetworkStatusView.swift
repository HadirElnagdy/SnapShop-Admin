//
//  NetworkStatusView.swift
//  SnapShop-Admin
//
//  Created by Hadir on 12/06/2024.
//

import SwiftUI

struct NetworkStatusView: View {
    
    
    var body: some View {
        VStack {
            if !AppCommon.shared.isNetworkReachable() {
                Text("No Network Connection")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
            }
            Spacer()
        }
    }
}

#Preview {
    NetworkStatusView()
}
