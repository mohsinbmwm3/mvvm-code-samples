protocol LoginViewModelDelegate: AnyObject {
    func didLoginSuccessfully(user: User)
    func didFailWithError(message: String)
    func updateLoadingState(isLoading: Bool)
}

class LoginViewModel {
    private let authService: AuthService
    weak var delegate: LoginViewModelDelegate?

    init(authService: AuthService) {
        self.authService = authService
    }

    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            delegate?.didFailWithError(message: "Email and password cannot be empty.")
            return
        }

        delegate?.updateLoadingState(isLoading: true)
        authService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.updateLoadingState(isLoading: false)
                switch result {
                case .success(let user):
                    self?.delegate?.didLoginSuccessfully(user: user)
                case .failure(let error):
                    let message: String
                    switch error {
                    case .invalidCredentials:
                        message = "Invalid email or password."
                    case .networkFailure:
                        message = "Network error. Please try again."
                    case .unknown:
                        message = "An unknown error occurred."
                    }
                    self?.delegate?.didFailWithError(message: message)
                }
            }
        }
    }
}
