//
//  WeatherRespository.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func fetchWeather(for city: String) async throws -> WeatherInfo
}

final class WeatherRepository: WeatherRepositoryProtocol {
    private let service: WeatherServiceProtocol

    init(service: WeatherServiceProtocol) {
        self.service = service
    }

    func fetchWeather(for city: String) async throws -> WeatherInfo {
        // 1. Get raw response from the service (network call)
        let rawData = try await service.fetchCurrentWeather(city: city)
        
        // 2. Convert WeatherResponse -> WeatherInfo (domain model)
        return WeatherInfo(
            cityName: rawData.location.name,
            temperature: rawData.current.tempC,
            conditionText: rawData.current.condition.text,
            conditionIconURL: URL(string: "https:\(rawData.current.condition.icon)"),
            humidity: rawData.current.humidity,
            uvIndex: rawData.current.uv,
            feelsLike: rawData.current.feelslikeC
        )
    }
}
