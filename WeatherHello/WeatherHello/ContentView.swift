//
//  ContentView.swift
//  WeatherHello
//
//  Created by Anita Stashevskaya on 25.05.2022.
//

import SwiftUI
struct ContentView: View {
    
    @State private var isNight = false
    @State public var searchText = ""

    var body: some View {
        //NavigationView {
        ZStack {
            BackgroundView(topColor: isNight ? .black : Color("topGradient"),
                           bottomColor: isNight ? .gray : Color("bottomGradient"))
            VStack() {
                HStack{
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    getWeatherForecast(for: searchText)
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title3)
                  }
                }
                CityView(cityName: searchText)
                //let key = "d2b758466054981c7a9596f7549c12be";
                //var url = "api.openweathermap.org/data/2.5/forecast?q=\(searchText)&appid=\(key)&units=metric"

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
                
                Button {
                    isNight.toggle()
                } label: {
                    ChangeDayView(imageName: "sun.min")
                }
                Spacer()
            }
        }

    }
    
    func getWeatherForecast(for location: String) {
        let apiService = APIService.shared
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
            
//&units=metric
        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/weather?q=\(location)&appid=d2b758466054981c7a9596f7549c12be&units=metric",
                           dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIService.APIError>) in
            switch result {
            case .success(let forecast):
                for day in forecast.daily {//daily
                    print(dateFormatter.string(from:day.dt))
                    print("Humidity: ", day.humidity)
                    print("Clouds: ", day.clouds)
                    print("IconURL: ", day.weather[0].weatherIconURL)//equal string
                    print("Temperature: ", day.temp)
                }
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString )
                }
            }
          }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
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
            Image(systemName: imageDay)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .light, design: .default))
                .foregroundColor(.white)
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
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 100)
            
            Text("\(degrees)°")
                .font(.system(size: 40, weight: .light, design: .default))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

