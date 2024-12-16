protocol AuthService {
    func login(email: String, password: String, completion: @escaping (Result<User, LoginError>) -> Void)
}

class AuthServiceImpl: AuthService {
    func login(email: String, password: String, completion: @escaping (Result<User, LoginError>) -> Void) {
        // Simulating a network call
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            if email == "test@example.com" && password == "password" {
                let user = User(id: 1, name: "Test User", email: email)
                completion(.success(user))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
}
