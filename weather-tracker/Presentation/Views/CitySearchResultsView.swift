//
//  CitySearchResultsView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore
import SwiftUI

struct CitySearchResultsView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Binding var isShowingSearchResults: Bool

    var body: some View {
        List(viewModel.searchResults, id: \.name) { item in
            Button {
                Task {
                    await viewModel.fetchWeather(for: item.name)
                    isShowingSearchResults = false
                }
            } label: {
                CityCardView(cityName: item.name, temperature: viewModel.getTemperature(for: "\(item.lat)"))
            }
            .listRowBackground(Color.clear)
            .buttonStyle(PlainButtonStyle())
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
    }
}
