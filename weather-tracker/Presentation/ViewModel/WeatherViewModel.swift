//
//  WeatherViewModel.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    // Published properties for your view to watch
    @Published var weatherInfo: WeatherInfo?
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let repository: WeatherRepositoryProtocol
    private let cityStorage: CityStorage

    init(repository: WeatherRepositoryProtocol, cityStorage: CityStorage) {
        self.repository = repository
        self.cityStorage = cityStorage
    }

    // Load the last selected city when the app starts
    func loadSavedCity() {
        if let savedCity = cityStorage.loadCity() {
            searchQuery = savedCity
            Task { await fetchWeather(for: savedCity) }
        }
    }

    // Main method to fetch weather
    func fetchWeather(for city: String) async {
        guard !city.isEmpty else { return }
        isLoading = true
        errorMessage = nil

        do {
            let info = try await repository.fetchWeather(for: city)
            weatherInfo = info
            cityStorage.saveCity(city)     // Save to local storage
        } catch let serviceError as WeatherServiceError {
            // Handle our custom WeatherServiceError cases
            errorMessage = serviceError.localizedDescription
        } catch {
            // Handle any other unknown errors
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }

        isLoading = false
    }

    // Optional: Called from a button or tapping a search result
    func selectCity(_ city: String) {
        searchQuery = city
        Task { await fetchWeather(for: city) }
    }
}
