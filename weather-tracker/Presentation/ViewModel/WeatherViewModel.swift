//
//  WeatherViewModel.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    //ViewModel: Updates its @Published properties (e.g., weatherInfo) to notify the View of changes.
    @Published var weatherInfo: WeatherInfo?
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var saveCity : String?
    @Published var searchResults: [CitySearchItem] = []

    private let repository: WeatherRepositoryProtocol
    private let cityStorage: CityStorage

    init(repository: WeatherRepositoryProtocol, cityStorage: CityStorage) {
        self.repository = repository
        self.cityStorage = cityStorage
    }

    func loadSavedCity() {
        if let savedCity = cityStorage.loadCity() {
            Task { await fetchWeather(for: savedCity) }
        }
    }
    
    func saveCity(_ city: String) {
        cityStorage.saveCity(city)
        saveCity = city
    }

    func fetchWeather(for city: String) async {
        guard !city.isEmpty else { return }
        isLoading = true
        errorMessage = nil

        do {
            let info = try await repository.fetchWeather(for: city)
            weatherInfo = info
            saveCity(city)
        } catch let serviceError as WeatherServiceError {
            errorMessage = serviceError.localizedDescription
        } catch {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }

        isLoading = false
    }

    
    func fetchSearchCity(query: String) async {
        guard !query.isEmpty else {
            
            searchResults = []
            return
        }
            isLoading = true
            errorMessage = nil

            do {
                let results = try await repository.searchCities(matching: query)
                searchResults = results
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    
    
    func getTemperature(for cityName: String) -> Double {
           
            if let weather = weatherInfo, weather.cityName == cityName {
                return weather.temperature
            }
            return 0.0
        }
    
}


class MockWeatherViewModel: WeatherViewModel {
    init() {
        let mockRepository = MockWeatherRepository()
        let mockCityStorage = MockCityStorage()
        super.init(repository: mockRepository, cityStorage: mockCityStorage)

        // Add mock data for the preview
        searchResults = [
            CitySearchItem(id: 37, name: "San Francisco", region: "-122.4194" , country: "https://www.google.com", lat: 0.0, lon: 0.0, url: ""),
            CitySearchItem(id: 37, name: "San Francisco", region: "122.4194" , country: "https://www.google.com", lat: 0.0, lon:0.0 , url: ""),
            CitySearchItem(id: 37, name: "San Francisco", region: "122.4194" , country: "https://www.google.com", lat: 0.0, lon: 0.0 , url : "")
        ]
    }

    override func getTemperature(for cityName: String) -> Double {
        return 72.0 // Example temperature for all cities
    }
}
