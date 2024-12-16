import UIKit

class LoginViewController: UIViewController, LoginViewModelDelegate {
    
    // Storyboard Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let viewModel: LoginViewModel

    // Custom Initializer
    init?(coder: NSCoder, viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        errorLabel.text = ""
        activityIndicator.hidesWhenStopped = true
    }

    // Action linked to the Login Button
    @IBAction func loginTapped(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }

    // MARK: - LoginViewModelDelegate
    func didLoginSuccessfully(user: User) {
        errorLabel.text = ""
        let alert = UIAlertController(title: "Welcome", message: "Hello, \(user.name)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func didFailWithError(message: String) {
        errorLabel.text = message
    }

    func updateLoadingState(isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            loginButton.isEnabled = false
        } else {
            activityIndicator.stopAnimating()
            loginButton.isEnabled = true
        }
    }
}
