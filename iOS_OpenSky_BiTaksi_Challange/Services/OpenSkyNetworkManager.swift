//
//  OpenSkyNetworkManager.swift
//  OpenSkyNetworkChallange
//
//  Created by Erkut Baş on 5/31/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation

class OpenSkyNetworkManager {
    
    public static let shared = OpenSkyNetworkManager()
    
    
    /// Description: generic url request function
    ///
    /// - Parameters:
    ///   - type: any codable class
    ///   - urlRequest: urlRequest to specified API type
    ///   - completion: decoded json data object
    /// - Author: Erkut Bas
    func startUrlRequest<T: Codable>(type: T.Type, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("error : \(error)")
            }
            print("check1")
            if let data = data {
                do {
                    let dataDecoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(dataDecoded))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(BackendApiError.missingDataError))
            }
            
        }
        
        task.resume()
        
        
    }
    
    /// Description: creates url request for google api calls
    ///
    /// - Parameter googleApiCallStruct: required attributes to create url components and request
    /// - Returns: Url request
    func createUrlRequest(openSkyNetworkRequestStruct: OpenSkyNetworkRequestStruct) -> URLRequest? {
        
        let urlString = openSkyNetworkRequestStruct.urlString
        guard let urlInitial = URL(string: urlString) else { return nil }
        var urlComponent = URLComponents(url: urlInitial, resolvingAgainstBaseURL: false)
        
        switch openSkyNetworkRequestStruct.callType {
        case .stateVectorsAll:
            urlComponent?.queryItems = [URLQueryItem(name: "lamin", value: openSkyNetworkRequestStruct.lamin), URLQueryItem(name: "lomin", value: openSkyNetworkRequestStruct.lomin), URLQueryItem(name: "lamax", value: openSkyNetworkRequestStruct.lamax), URLQueryItem(name: "lomax", value: openSkyNetworkRequestStruct.lomax)]
            
        case .updatedLocationValue:
            urlComponent?.queryItems = [URLQueryItem(name: "icao24", value: openSkyNetworkRequestStruct.ica024), URLQueryItem(name: "time", value: openSkyNetworkRequestStruct.time)]
            break
        }
        
        guard let component = urlComponent else { return nil }
        guard let url = component.url else { return nil }
        
        return URLRequest(url: url)
        
    }
    
}
