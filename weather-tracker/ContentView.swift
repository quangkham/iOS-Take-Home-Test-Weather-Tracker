//
//  ContentView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel(
        repository: WeatherRepository(service: WeatherService(apiKey: Bundle.main.apiKey)),
        cityStorage: CityStorage()
    )

    var body: some View {
            VStack {
                // Search bar at the top
                HStack {
                    TextField("Search Location", text: $viewModel.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            Task { await viewModel.fetchWeather(for: viewModel.searchQuery) }
                        }
                    Button(action: {
                        Task { await viewModel.fetchWeather(for: viewModel.searchQuery) }
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .padding()

                // Main content
                if let weather = viewModel.weatherInfo {
                    WeatherDetailView(weatherInfo: weather)
                } else if viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    // No city saved yet -> show prompt
                    EmptyHomeView()
                }
            }
        
        .onAppear {
            viewModel.loadSavedCity()
        }
        // Present an alert if `errorMessage` is non-nil
        .alert(
            // A bool binding that is true when errorMessage isn't nil
            isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { newVal in
                    // If the alert is dismissed, reset errorMessage to nil
                    if !newVal {
                        viewModel.errorMessage = nil
                    }
                }
            )
        ) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Unknown error"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
