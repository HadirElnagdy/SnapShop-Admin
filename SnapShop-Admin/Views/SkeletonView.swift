////
////  SkeletonView.swift
////  SnapShop-Admin
////
////  Created by Hadir on 08/06/2024.
////
//
//import SwiftUI
//
//struct GenericListView<ViewModel: ListViewModel, Content: View>: View {
//    @StateObject var viewModel: ViewModel
//    @State var openAddItemView: Bool = false
//    @State var searchQuery = ""
//    @State var selectedItem: ViewModel.ItemType? = nil
//    let addItemView: () -> Content
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                GridView(items: viewModel.itemList, deleteItem: { item in
//                    selectedItem = item
//                })
//            }
//            .navigationBarTitle("Items")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        openAddItemView.toggle()
//                    } label: {
//                        Image(systemName: "plus.app")
//                            .font(.system(size: 24))
//                    }
//                    .sheet(isPresented: $openAddItemView) {
//                        addItemView()
//                    }
//                }
//            }
//            .alert(item: $selectedItem) { item in
//                Alert(
//                    title: Text("Confirm Deletion"),
//                    message: Text("Are you sure you want to delete this item?"),
//                    primaryButton: .destructive(Text("Delete")) {
//                        viewModel.deleteItem(item: item)
//                    },
//                    secondaryButton: .cancel(Text("Cancel"))
//                )
//            }
//            .onAppear {
//                viewModel.getItems()
//            }
//        }
//    }
//}
//
//
//#Preview {
//    SkeletonView()
//}
