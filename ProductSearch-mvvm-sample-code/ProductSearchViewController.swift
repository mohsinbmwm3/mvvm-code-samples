import UIKit

class ProductSearchViewController: UIViewController, ProductSearchViewModelDelegate, UITableViewDataSource {
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private var displayedProducts: [Product] = []
    private let viewModel: ProductSearchViewModel

    init(viewModel: ProductSearchViewModel) {
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
    }

    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        searchBar.delegate = self

        tableView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height - 50)
        tableView.dataSource = self
    }

    // MARK: - ProductSearchViewModelDelegate
    func didUpdateSearchResults(_ products: [Product]) {
        displayedProducts = products
        tableView.reloadData()
    }

    func didFailWithError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ProductCell")
        let product = displayedProducts[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.category
        return cell
    }
}

// SearchBar Extension
extension ProductSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchProducts(query: searchText)
    }
}
