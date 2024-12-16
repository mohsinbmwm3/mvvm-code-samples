// Service
protocol WeatherService {
    func fetchWeather(for city: String) -> String
}

class MockWeatherService: WeatherService {
    func fetchWeather(for city: String) -> String {
        return "Sunny, 25°C in \(city)"
    }
}

// ViewModel
class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var weather: String = ""
    
    private let service: WeatherService
    
    init(service: WeatherService) {
        self.service = service
    }
    
    func getWeather() {
        weather = service.fetchWeather(for: city)
    }
}

// View
struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel(service: MockWeatherService())
    
    var body: some View {
        VStack {
            TextField("Enter city", text: $viewModel.city)
            Button("Get Weather", action: viewModel.getWeather)
            Text(viewModel.weather)
        }
    }
}
