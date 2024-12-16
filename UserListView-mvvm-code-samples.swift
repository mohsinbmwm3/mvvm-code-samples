// Model
struct User: Identifiable, Decodable {
    let id: Int
    let name: String
}

// ViewModel
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    
    func fetchUsers() {
        isLoading = true
        URLSession.shared.dataTask(with: URL(string: "https://somejsonendpoint.developer.com/users")!) { data, _, _ in
            if let data = data, let users = try? JSONDecoder().decode([User].self, from: data) {
                DispatchQueue.main.async {
                    self.users = users
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

// View
struct UserListView: View {
    @StateObject var viewModel = UserListViewModel()
    
    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }
        .onAppear { viewModel.fetchUsers() }
        .overlay(viewModel.isLoading ? ProgressView() : nil)
    }
}
