struct User {
    let id: Int
    let name: String
    let email: String
}

enum LoginError: Error {
    case invalidCredentials
    case networkFailure
    case unknown
}
