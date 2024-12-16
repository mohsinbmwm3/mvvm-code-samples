protocol ProductSearchViewModelDelegate: AnyObject {
    func didUpdateSearchResults(_ products: [Product])
    func didFailWithError(_ error: Error)
}

class ProductSearchViewModel {
    weak var delegate: ProductSearchViewModelDelegate?
    private let apiService: ProductAPI

    init(apiService: ProductAPI) {
        self.apiService = apiService
    }

    func searchProducts(query: String) {
        apiService.fetchProducts(searchQuery: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.delegate?.didUpdateSearchResults(products)
                case .failure(let error):
                    self?.delegate?.didFailWithError(error)
                }
            }
        }
    }
}
