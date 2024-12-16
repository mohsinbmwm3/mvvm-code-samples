// ViewModel
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isFormValid: Bool = false
    
    func validateForm() {
        isFormValid = !email.isEmpty && email.contains("@") && password.count >= 6
    }
}

// View
struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .onChange(of: viewModel.email) { _ in viewModel.validateForm() }
            SecureField("Password", text: $viewModel.password)
                .onChange(of: viewModel.password) { _ in viewModel.validateForm() }
            
            Button("Login") { print("Login!") }
                .disabled(!viewModel.isFormValid)
        }
    }
}
