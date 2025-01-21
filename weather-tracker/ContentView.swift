//
//  ContentView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = WeatherViewModel( // dependency injection
        repository: WeatherRepository(service: WeatherService(apiKey: Bundle.main.apiKey)),
        cityStorage: CityStorage()
    )
    @State private var isLoading = false
    
    var body: some View {
            VStack {
                CustomSearchBar(
                text: $viewModel.searchQuery,
                placeholder: "Search Location"
                ).onChange(of: viewModel.searchQuery) { newValue in
                    debounce(milliseconds: 300) {
                        Task {
                            await viewModel.fetchSearchCity(query: newValue)
                        }
                    }
                    
                }
                .padding(.top, 20)
                
                if !viewModel.searchQuery.isEmpty && viewModel.searchResults.isEmpty {
                    Text("No results found")
                        .font(.poppinsCaption)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                }

                if !viewModel.searchQuery.isEmpty && !viewModel.searchResults.isEmpty  {
                    CitySearchResultsView(viewModel: viewModel, onCitySelected: { selectedCity in
                        Task {
                            await viewModel.fetchWeather(for: selectedCity)
                                viewModel.searchQuery = ""
                            }
                    })
                }
                else
                {
                    if let weatherInfo = viewModel.weatherInfo {
                        WeatherDetailView(weatherInfo: weatherInfo)
                    }
                    else {
                        EmptyHomeView()
                    }
                    
                }
                
            }
        
        .onAppear {
            Task {
                await loadInitialData()
            }
        }
        
        .alert(
            
            isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { newVal in
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
    
    private func loadInitialData() async {
            viewModel.loadSavedCity()
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            isLoading = false
    }
    
    
    func debounce(milliseconds: Int, action: @escaping () -> Void) {
        let delay = DispatchTime.now() + .milliseconds(milliseconds)
        DispatchQueue.main.asyncAfter(deadline: delay, execute: action)
    }

}
