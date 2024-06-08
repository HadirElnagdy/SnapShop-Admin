//
//  ListViewModel.swift
//  SnapShop-Admin
//
//  Created by Hadir on 08/06/2024.
//

import Foundation

protocol ListViewModel: ObservableObject {
    associatedtype ItemType: Identifiable
    var itemList: [ItemType] { get }
    func getItems()
    func deleteItem(item: ItemType)
}
