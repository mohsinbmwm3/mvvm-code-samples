// ViewModel
class ItemViewModel: ObservableObject {
    @Published var items: [String] = ["Item 1", "Item 2", "Item 3"]
    @Published var selectedItem: String? = nil
}

// Master View
struct ItemListView: View {
    @StateObject var viewModel = ItemViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.items, id: \.self) { item in
                NavigationLink(destination: ItemDetailView(viewModel: viewModel)) {
                    Text(item)
                        .onTapGesture {
                            viewModel.selectedItem = item
                        }
                }
            }
        }
    }
}

// Detail View
struct ItemDetailView: View {
    @ObservedObject var viewModel: ItemViewModel
    
    var body: some View {
        Text(viewModel.selectedItem ?? "No Item Selected")
    }
}
