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
    
    @State private var isShowingSearchResults = false
    
    var body: some View {
            VStack {
                CustomSearchBar(
                text: $viewModel.searchQuery,
                placeholder: "Search Location"
                ).onChange(of: viewModel.searchQuery) { newValue in
                    Task {
                        await viewModel.fetchSearchCity(query: newValue)
                        isShowingSearchResults = !viewModel.searchResults.isEmpty
                    }
                }
                .padding(.top, 20)

                if isShowingSearchResults {
                    
                    CitySearchResultsView(viewModel: viewModel, isShowingSearchResults: $isShowingSearchResults)
                } else {
                   
                    if let weather = viewModel.weatherInfo {
                        WeatherDetailView(cityName: weather.cityName)
                    } else if viewModel.isLoading {
                            ProgressView("Loading...")
                    } else {
                            EmptyHomeView()
                    }
                }
            }
        
        .onAppear {
            viewModel.loadSavedCity()
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
}
