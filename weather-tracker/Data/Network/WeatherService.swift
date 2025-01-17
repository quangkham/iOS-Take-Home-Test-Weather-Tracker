//
//  WeatherService.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUI

import Foundation

protocol WeatherServiceProtocol {
    func fetchCurrentWeather(city: String) async throws -> WeatherResponse
}

final class WeatherService: WeatherServiceProtocol {
    private let session: URLSession
    private let apiKey: String
    
    init(session: URLSession = .shared, apiKey: String) {
        self.session = session
        self.apiKey = apiKey
    }
    
    func fetchCurrentWeather(city: String) async throws -> WeatherResponse {
        // 1. Get the API key
        let apiKey = Bundle.main.apiKey
        guard !apiKey.isEmpty else {
            throw WeatherServiceError.emptyAPIKey
        }
        
        // 2. Build the URL
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)"
        guard let url = URL(string: urlString) else {
            throw WeatherServiceError.invalidURL
        }
        
        do {
            // 3. Execute the request
            let (data, response) = try await session.data(from: url)
            
            // 4. Validate response
            guard let httpResponse = response as? HTTPURLResponse else {
                throw WeatherServiceError.unknown(URLError(.badServerResponse))
            }
            guard httpResponse.statusCode == 200 else {
                throw WeatherServiceError.invalidResponseCode(httpResponse.statusCode)
            }
            
            // 5. Decode JSON
            do {
                let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                return decoded
            } catch {
                throw WeatherServiceError.decodingFailure
            }
            
        } catch {
            // Catch any other errors from session.data or network
            throw WeatherServiceError.unknown(error)
        }
    }
}




