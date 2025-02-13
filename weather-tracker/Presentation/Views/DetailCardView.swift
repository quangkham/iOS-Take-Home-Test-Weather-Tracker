//
//  DetailCardView.swift
//  weather-tracker
//
//  Created by Quang Kham on 17/1/25.
//

import SwiftUICore

struct DetailCardView: View {
    let label: String
    let value: String

    var body: some View {
        VStack {
            Text(label)
                .font(.poppinsBody)
                .foregroundColor(.brandForeground)
            Text(value)
                .font(.poppinsHeadline)
                .foregroundColor(.brandForeground)
        }
        .frame(maxWidth: .infinity)
    }
}
