//
//  APIService.swift
//  WeatherHello
//
//  Created by Anita Stashevskaya on 27.05.2022.
//

import Foundation

public class APIService {
    public static let shared = APIService()
    public enum APIError : Error {
        case error(_errorString: String)
    }
    
    public  func getJSON <T: Decodable>(urlString: String,
                                        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                        keyDecodinfStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                        completion: @escaping (Result<T, APIError >) -> Void) {
        guard let url = URL(string: urlString ) else {
            completion(.failure(.error(_errorString: NSLocalizedString("Error: Invalid url", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(_errorString: "Error: \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.error(_errorString: NSLocalizedString("Error: Invalid url", comment: ""))))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodinfStrategy
            do {
                let decodedData =  try decoder.decode(Forecast.self, from: data)
                completion(.success(decodedData as! T))
                return
            } catch let decodingError {
                completion(.failure(APIError.error(_errorString: "Error: \(decodingError.localizedDescription)")))
                return
            }
        }.resume()
    }
}
