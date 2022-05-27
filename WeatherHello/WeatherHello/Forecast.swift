//
//  Forecast.swift
//  WeatherHello
//
//  Created by Anita Stashevskaya on 27.05.2022.
//

import Foundation

struct Forecast: Codable {
    struct Daily: Codable {
        let dt: Date
        struct Temp: Codable {
            let feels_like: Double//day temperature
        }
        let temp: Temp
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
    let daily: [Daily]
}
