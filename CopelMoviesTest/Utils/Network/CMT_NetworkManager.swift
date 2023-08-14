//
//  CMT_NetworkManager.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

struct FavoriteMoviesListResponse: Codable {
    let results: [Pelicula]?

}

class CMT_NetworkManager {
    static let shared = CMT_NetworkManager()
    
    public var apiKey = "e142ca6d5b52024931683472e1abbef2"
    public var userName = ""
    public var request_token = ""
    public var sesionID = ""
    public var initialPath = "https://api.themoviedb.org/3/"
    public var firstURL: String = "https://image.tmdb.org/t/p/w500"
    
    private init() {}
    
    func realizarSolicitud<T: Decodable>(url: URL, method: String, queryItems: [String: String]? = nil, body: Data? = nil, requestType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems?.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let finalURL = urlComponents?.url else {
            DispatchQueue.main.async {
                completionHandler(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            }
            return
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                }
                return
            }
            
            do {
                let respuestaDecodificada = try JSONDecoder().decode(requestType, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(respuestaDecodificada))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }

}

