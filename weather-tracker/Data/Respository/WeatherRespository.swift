//
//  WeatherRespository.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func fetchWeather(for city: String) async throws -> WeatherInfo
    func searchCities(matching query: String) async throws -> [CitySearchItem]
}

final class WeatherRepository: WeatherRepositoryProtocol {
    private let service: WeatherServiceProtocol

    init(service: WeatherServiceProtocol) {
        self.service = service
    }

    func fetchWeather(for city: String) async throws -> WeatherInfo {
        
        let rawData = try await service.fetchCurrentWeather(city: city)
        
        return WeatherInfo(
            cityName: rawData.location.name,
            temperature: rawData.current.tempC,
            conditionText: rawData.current.condition.text,
            conditionIconURL: URL(string: "https:\(rawData.current.condition.icon)"),
            humidity: rawData.current.humidity,
            uvIndex: rawData.current.uv,
            feelsLike: rawData.current.feelslikeC,
            windSpeed: rawData.current.windSpeed,
            windDirection: rawData.current.windDirection,
            pressure: rawData.current.pressure,
            lastUpdated: rawData.current.lastUpdated
        )
    }
    
    func searchCities(matching query: String) async throws -> [CitySearchItem] {
        let results = try await service.searchCities(matching: query)
           
           return results
       }
    
    
}
