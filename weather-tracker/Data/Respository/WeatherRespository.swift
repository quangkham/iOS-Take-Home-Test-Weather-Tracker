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


class MockWeatherRepository: WeatherRepositoryProtocol {
    func fetchWeather(for city: String) async throws -> WeatherInfo {
        
        return WeatherInfo(
        cityName : "",
        temperature: 0.0,
        conditionText: "rawData.current.condition.text",
        conditionIconURL: URL(string: "https:"),
        humidity: 0,
        uvIndex: 0.0,
        feelsLike: 0.0,
        windSpeed:0.0,
        windDirection: "rawData.current.windDirection",
        pressure: 0.0,
        lastUpdated: "rawData.current.lastUpdated")
        
    }

    func searchCities(matching query: String) async throws -> [CitySearchItem] {
        return [
            CitySearchItem(id: 37, name: "San Francisco", region: "-122.4194" , country: "https://www.google.com", lat: 0.0, lon: 0.0, url: ""),
            CitySearchItem(id: 37, name: "San Francisco", region: "122.4194" , country: "https://www.google.com", lat: 0.0, lon:0.0 , url: ""),
            CitySearchItem(id: 37, name: "San Francisco", region: "122.4194" , country: "https://www.google.com", lat: 0.0, lon: 0.0 , url : "")
        ]
    }
    
}

