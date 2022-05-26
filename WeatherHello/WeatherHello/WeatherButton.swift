//
//  WeatherButton.swift
//  WeatherHello
//
//  Created by Anita Stashevskaya on 25.05.2022.
//
import SwiftUI

struct ChangeDayView: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
    }
}
