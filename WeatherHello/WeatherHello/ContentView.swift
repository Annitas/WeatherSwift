//
//  ContentView.swift
//  WeatherHello
//
//  Created by Anita Stashevskaya on 25.05.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            
            
            BackgroundView(topColor: isNight ? .black : Color("topGradient"),
                           bottomColor: isNight ? .gray : Color("bottomGradient"))
            VStack {
                CityView(cityName: "Omsk")
                
                WeatherIconView(weatherIcon: "cloud.sun.rain.fill", degrees: 23)
                
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
                
                Button {//btn do
                    isNight.toggle()
                } label: {
                    ChangeDayView(imageName: "sun.min")
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
            //ContentView()
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

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(colors: [topColor, bottomColor],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CityView: View {
    var cityName: String
     
    var body: some View {
        Text(cityName)
            .font(.system(size: 30, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding(5)
    }
}

struct WeatherIconView: View {
    var weatherIcon: String
    var degrees: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: weatherIcon)
                .renderingMode(.original)//make icon colorful
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 100)
            
            Text("\(degrees)°")
                .font(.system(size: 40, weight: .light, design: .default))
                .foregroundColor(.white)//degrees
        }
        .padding(.bottom, 40)
    }
}

