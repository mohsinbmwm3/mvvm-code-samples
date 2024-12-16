// Model: Model should be in its seperate file and folder structure
struct Product {
    let id: Int
    let name: String
    let category: String
}

// ViewModel: keep this in seperate file
protocol ProductViewModelDelegate: AnyObject {
    func didUpdateProducts(_ products: [Product])
}

class ProductViewModel {
    private var allProducts: [Product] = []
    private var filteredProducts: [Product] = []
    weak var delegate: ProductViewModelDelegate?

    init(products: [Product]) {
        self.allProducts = products
        self.filteredProducts = products
    }

    func getProducts() -> [Product] {
        return filteredProducts
    }

    func filterProducts(by category: String) {
        if category.isEmpty {
            filteredProducts = allProducts
        } else {
            filteredProducts = allProducts.filter { $0.category == category }
        }
        delegate?.didUpdateProducts(filteredProducts)
    }
}
