//
//  WeatherDetailView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore
import SwiftUI

struct WeatherDetailView: View {
    let cityName: String
    @State private var weatherInfo: WeatherInfo?
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
                
            if isLoading {
                ProgressView("Loading...")
            } else if let weatherInfo = weatherInfo {
                
                if let iconURL = weatherInfo.conditionIconURL {
                    AsyncImage(url: iconURL) { phase in
                        switch phase {
                            case .empty:
                                ProgressView()
                                .frame(width: 100, height: 100)
                            case .success(let image):
                                image.resizable()
                                .scaledToFit()
                                .frame(width: 123, height: 123)
                            case .failure:
                                Image(systemName: "cloud.sun.fill")
                                .font(.largeTitle)
                            @unknown default:
                                EmptyView()
                                }
                            }
                        }

                     HStack {
                            Text(weatherInfo.cityName)
                             .font(.poppinsTitle)
                            Image(systemName: "location.fill")
                             .foregroundColor(.brandBackground)
                            }

                        Text("\(Int(weatherInfo.temperature))°")
                            .font(.poppinsHeader)
                        }

                   
                    HStack(spacing: 16) {
                        DetailCardView(label: "Humidity", value: "\(weatherInfo?.humidity ?? 0)%")
                        DetailCardView(label: "UV", value: "\(Int(weatherInfo?.uvIndex ?? 0.0))")
                        DetailCardView(label: "Feels Like", value: "\(Int(weatherInfo?.feelsLike ?? 0.0))°")
                            }
                            .padding()
                            .background(content: { Color.brandLightForeground.cornerRadius(16) })
                            Spacer()
                }
                .padding()
                .onAppear() {
                    Task {
                        await fetchWeather()
                    }
        }
    }
    
    private func fetchWeather() async {
            do {
                isLoading = true
                let repository = WeatherRepository(service: WeatherService(apiKey: Bundle.main.apiKey))
                weatherInfo = try await repository.fetchWeather(for: cityName)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
}
