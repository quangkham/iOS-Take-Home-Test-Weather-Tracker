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
    func searchCities(matching query: String) async throws -> [CitySearchItem]
}

final class WeatherService: WeatherServiceProtocol {
    private let session: URLSession
    private let apiKey: String
    
    init(session: URLSession = .shared, apiKey: String) {
        self.session = session
        self.apiKey = apiKey
    }
    
    func fetchCurrentWeather(city: String) async throws -> WeatherResponse {
       
        guard !self.apiKey.isEmpty else {
            throw WeatherServiceError.emptyAPIKey
        }
        
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(self.apiKey)&q=\(city)"
 
        guard let url = URL(string: urlString) else {
            throw WeatherServiceError.invalidURL
        }
        
        do {
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw WeatherServiceError.unknown(URLError(.badServerResponse))
            }
            guard httpResponse.statusCode == 200 else {
                throw WeatherServiceError.invalidResponseCode(httpResponse.statusCode)
            }
            
            do {
                let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                return decoded
            } catch {
                throw WeatherServiceError.decodingFailure
            }
            
        } catch {
            
            throw WeatherServiceError.unknown(error)
        }
    }
    
    func searchCities(matching query: String) async throws -> [CitySearchItem] {
        
        guard !self.apiKey.isEmpty else {
            throw WeatherServiceError.emptyAPIKey
        }
        
        let urlString = "https://api.weatherapi.com/v1/search.json?key=\(self.apiKey)&q=\(query)"
      
        
        guard let url = URL(string: urlString) else {
            throw WeatherServiceError.invalidURL
        }
        
        do {
            
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw WeatherServiceError.unknown(URLError(.badServerResponse))
            }
            guard httpResponse.statusCode == 200 else {
                throw WeatherServiceError.invalidResponseCode(httpResponse.statusCode)
            }
            
            
            do {
                let decoded = try JSONDecoder().decode([CitySearchItem].self, from: data)
                return decoded
            } catch {
                throw WeatherServiceError.decodingFailure
            }
            
        } catch {
           
            throw WeatherServiceError.unknown(error)
        }
    }
}




