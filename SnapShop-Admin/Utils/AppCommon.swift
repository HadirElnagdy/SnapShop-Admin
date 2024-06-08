//
//  AppCommon.swift
//  SnapShop-Admin
//
//  Created by Hadir on 02/06/2024.
//

import Foundation
import Reachability
import SwiftUI

class AppCommon{
    
    public static let shared = AppCommon()

    private let reachability = try! Reachability()

    private init() {
        startMonitoring()
    }

    private func startMonitoring() {
        reachability.whenReachable = { _ in
            print("Network is reachable")
        }
        reachability.whenUnreachable = { _ in
            print("No Network!!")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    func isNetworkReachable() -> Bool {
        return reachability.connection != .unavailable
    }
    
 


    
}
    
