protocol ProductAPI {
    func fetchProducts(searchQuery: String, completion: @escaping (Result<[Product], Error>) -> Void)
}

class ProductAPIService: ProductAPI {
    func fetchProducts(searchQuery: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = URL(string: "https://api.example.com/products?query=\(searchQuery)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    completion(.success(products))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
