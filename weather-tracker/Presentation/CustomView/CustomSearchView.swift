//
//  CustomSearchView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search Location"
    var onSearch: () -> Void = {}

    var body: some View {
        ZStack(alignment: .trailing) {
            TextField(placeholder, text: $text, onCommit: onSearch)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color(.systemGray6))
                .cornerRadius(23)
                .frame(height: 46)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.trailing, 16)
            }
        }
    }
}

struct SearchBarPreview: View {
    @State private var searchText = ""

    var body: some View {
        VStack {
            CustomSearchBar(text: $searchText) {
                print("Searching for \(searchText)")
            }
            Spacer()
        }
        .padding()
    }
}

struct SearchBarPreview_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarPreview().previewLayout(.sizeThatFits)
    }
}
