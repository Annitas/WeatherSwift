//
//  ContentView.swift
//  WeatherHello
//
//  Created by Anita Stashevskaya on 25.05.2022.
//

import SwiftUI
//import CoreLocation

class SearchBar: NSObject, ObservableObject {
    
    @Published var text: String = ""
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override init() {
        super.init()
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
    }
}

extension SearchBar: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        
        // Publish search bar text changes.
        if let searchBarText = searchController.searchBar.text {
            self.text = searchBarText
        }
    }
}
struct SearchBarModifier: ViewModifier {
    
    let searchBar: SearchBar
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchBar.searchController
                }
                    .frame(width: 0, height: 0)
            )
    }
}

extension View {
    
    func add(_ searchBar: SearchBar) -> some View {
        return self.modifier(SearchBarModifier(searchBar: searchBar))
    }
}

struct ContentView: View {
    
    @State private var isNight = false
    @State public var searchText = ""

    var body: some View {
        NavigationView {
        ZStack {
            BackgroundView(topColor: isNight ? .black : Color("topGradient"),
                           bottomColor: isNight ? .gray : Color("bottomGradient"))
            VStack {
                TextField("Search", text: $searchText)
                                    .padding(7)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    
                CityView(cityName: searchText)
                //--------------------------------------------------
                //let key = "d2b758466054981c7a9596f7549c12be";
                //var url = "api.openweathermap.org/data/2.5/forecast?q=\(searchText)&appid=\(key)&units=metric"
                //let urlString = NSURL(string: url)
                //let weatherObject = NSData(contentsOf: urlString! as URL)
                
                

                WeatherIconView(weatherIcon: "cloud.sun.rain.fill", degrees: 23)
                //-------------------------------------------------------
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
}

struct Forecast: Codable {
    struct FList: Codable {
        let dt: Date
        struct Temp: Codable {
            let day: Double//day temperature
        }
        let temperature: Temp
        let humidity: Int //humidity
        struct Weather: Codable {
            let icon: String //?
            var weatherIconURL: URL {
                let urlString = "http://openweathermap.org/img/wn/\(icon)@2x.png"
                return URL(string: urlString)!
            }
        }
        let weather: [Weather]
        let clouds: Int //clouds
    }
    let flist: [FList]
}

func kek(city: String) -> Void { 
let apiService = APIService.shared
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "E, MMM, d"
    

apiService.getJSON(urlString: "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=d2b758466054981c7a9596f7549c12be",
                   dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast, APIService.APIError>) in
    switch result {
    case .success(let forecast):
        for day in forecast.flist {//daily
            print(dateFormatter.string(from:day.dt))
            print("   Humidity: ", day.humidity)
            print("   Clouds: ", day.clouds)
            print("   IconURL: ", day.weather[0].weatherIconURL)//equal string
            print("   Temperature: ", day.temperature)
        }
    case .failure(let apiError):
        switch apiError {
        case .error(let errorString):
            print(errorString )
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

