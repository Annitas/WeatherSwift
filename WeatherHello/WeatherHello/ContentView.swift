//
//  ContentView.swift
//  WeatherHello
//
//  Created by Anita Stashevskaya on 25.05.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("topGradient"), Color("bottomGradient")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Omsk")
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding(5)
                VStack(spacing: 8) {
                    Image(systemName: "cloud.sun.rain.fill")
                        .renderingMode(.original)//make icon colorful
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 100)
                    
                    Text("27°")
                        .font(.system(size: 40, weight: .light, design: .default))
                        .foregroundColor(.white)//degrees
                }
                Spacer()
                HStack(spacing: 5) {
                    WeatherDayView(weekDay: "MON",
                                   imageDay: "cloud.sun.rain.fill",
                                   temperature: 20)
                    WeatherDayView(weekDay: "TUE",
                                   imageDay: "cloud.bolt.rain.fill",
                                   temperature: 20)
                    WeatherDayView(weekDay: "WED",
                                   imageDay: "cloud.rain.fill",
                                   temperature: 20)
                    WeatherDayView(weekDay: "THU",
                                   imageDay: "cloud.sun.bolt.fill",
                                   temperature: 20)
                    WeatherDayView(weekDay: "FRI",
                                   imageDay: "cloud.sleet.fill",
                                   temperature: 20)
                    WeatherDayView(weekDay: "SAT",
                                   imageDay: "cloud.fill",
                                   temperature: 20)
                }
                Spacer() 
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}

struct WeatherDayView: View {
    var weekDay: String
    var imageDay: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(weekDay)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageDay)//поправить фон
                .renderingMode(.original)//make icon colorful
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .light, design: .default))
                .foregroundColor(.white)//degrees
        }
    }
}
