import UIKit

class ProductViewController: UIViewController, ProductViewModelDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private let categoryTextField = UITextField()
    private var displayedProducts: [Product] = []

    private let viewModel: ProductViewModel

    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayedProducts = viewModel.getProducts()
    }

    private func setupUI() {
        view.addSubview(categoryTextField)
        view.addSubview(tableView)

        categoryTextField.frame = CGRect(x: 20, y: 50, width: 300, height: 40)
        categoryTextField.placeholder = "Enter category"
        categoryTextField.borderStyle = .roundedRect
        categoryTextField.addTarget(self, action: #selector(categoryDidChange), for: .editingChanged)

        tableView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height - 100)
        tableView.dataSource = self
    }

    @objc private func categoryDidChange() {
        viewModel.filterProducts(by: categoryTextField.text ?? "")
    }

    // MARK: - ProductViewModelDelegate
    func didUpdateProducts(_ products: [Product]) {
        displayedProducts = products
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ProductCell")
        let product = displayedProducts[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "Category: \(product.category)"
        return cell
    }
}

// Usage
let products = [
    Product(id: 1, name: "iPhone", category: "Electronics"),
    Product(id: 2, name: "MacBook", category: "Electronics"),
    Product(id: 3, name: "Shoes", category: "Clothing"),
    Product(id: 4, name: "T-Shirt", category: "Clothing"),
    Product(id: 5, name: "Blender", category: "Home Appliances")
]

let viewModel = ProductViewModel(products: products)
let productViewController = ProductViewController(viewModel: viewModel)

// Present or push `productViewController` in your app

