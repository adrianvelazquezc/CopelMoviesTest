//
//  CMT_DetailsInteractor.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import Foundation

class CMT_DetailsInteractor{
    var presenter: CMT_DetailsPresenterProtocol?
}

extension CMT_DetailsInteractor: CMT_DetailsInteractorProtocol {
    func fetchMovieDetails(movieId: Int) {
        let urlString = "\(CMT_NetworkManager.shared.initialPath)movie/\(movieId)"
        
        if let urlComponents = URLComponents(string: urlString) {
            if let urlObject = urlComponents.url {
                var urlRequest = URLRequest(url: urlObject)
                urlRequest.httpMethod = "GET"
                
                let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMTQyY2E2ZDViNTIwMjQ5MzE2ODM0NzJlMWFiYmVmMiIsInN1YiI6IjYzZWZkMTE1NGE0YmZjMDA5NjM3NDI1MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KC8kSYiVsqb59dcAEsFpeaoIAeV9LSLR8EP8XuH1PZc"
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                let task = URLSession.shared.dataTask(with: urlRequest) { responseData, response, error in
                    if let data = responseData,
                       let movieDetails = try? JSONDecoder().decode(MovieDetails.self, from: data) {
                        DispatchQueue.main.async {
                            self.presenter?.responseMovieDetails(movieDetails: movieDetails)
                        }
                    } else if let error = error {
                        DispatchQueue.main.async {
                            self.presenter?.responseError(error: error.localizedDescription, step: .getmovieDetails)
                        }
                    }
                }
                
                task.resume()
            }
        }
    }
    
    func fetchFavoriteMovie(isFavorite: Bool, movieId: Int) {
        let urlString = "\(CMT_NetworkManager.shared.initialPath)account/\(CMT_NetworkManager.shared.userName)/favorite?api_key=\(CMT_NetworkManager.shared.apiKey)&session_id=\(CMT_NetworkManager.shared.sesionID)"
        
        if let urlObject = URL(string: urlString){
            var urlRequest = URLRequest(url: urlObject)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            let body: [String: Any] = [
                "media_type": "movie",
                "media_id": movieId,
                "favorite": isFavorite
            ]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                self.presenter?.responseError(error: "Failed to create JSON body", step: .updateFavoriteMovie)
                return
            }
            
            urlRequest.httpBody = httpBody
            
            let task =  URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                if let respuestaDiferente = responseData {
                    if let data = try? JSONDecoder().decode(PeliculaLogin.self, from: respuestaDiferente){
                        if let success = data.success {
                            DispatchQueue.main.async {
                                if success == true {
                                    self.presenter?.responseFavoriteMovie()
                                }
                                else {
                                    self.presenter?.responseError(error: "Hubo un error", step: .updateFavoriteMovie)
                                }
                            }
                        }
                    }
                }
                if let respuestaError = responseError {
                    DispatchQueue.main.async {
                        self.presenter?.responseError(error: "\(respuestaError)", step: .updateFavoriteMovie)
                    }
                    return
                }
            }
            task.resume()
        }
    }
    
    func postDeleteSession() {
        let urlString = "\(CMT_NetworkManager.shared.initialPath)authentication/session"
        if var urlComponents = URLComponents(string: urlString) {
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: CMT_NetworkManager.shared.apiKey),
                URLQueryItem(name: "session_id", value: CMT_NetworkManager.shared.sesionID),
            ]
            
            if let urlObject = urlComponents.url {
                var urlRequest = URLRequest(url: urlObject)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "Delete"
                let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                    if let respuestaDiferente = responseData {
                        if let data = try? JSONDecoder().decode(PeliculaLogin.self, from: respuestaDiferente){
                            if let deleted = data.success {
                                DispatchQueue.main.async {
                                    if deleted{
                                        self.presenter?.responseDeletedSession()
                                    } else {
                                        self.presenter?.responseError(error: "Error al eliminar la sesion", step: .deleteSession)
                                    }
                                }
                            }
                        }
                    }
                    if let respuestaError = responseError {
                        DispatchQueue.main.async {
                            self.presenter?.responseError(error: "\(respuestaError)", step: .deleteSession)
                        }
                        return
                    }
                }
                task.resume()
            }
        }
    }
    
    func fetchFavoritesWithPresent() {
        let urlString = "\(CMT_NetworkManager.shared.initialPath)account/\(CMT_NetworkManager.shared.userName)/favorite/movies"
        if var urlComponents = URLComponents(string: urlString) {
            urlComponents.queryItems = [
                    URLQueryItem(name: "api_key", value: CMT_NetworkManager.shared.apiKey),
                    URLQueryItem(name: "session_id", value: CMT_NetworkManager.shared.sesionID),
                    URLQueryItem(name: "sort_by", value: "created_at.asc"),
                    URLQueryItem(name: "page", value: "1"),
            ]
            
            if let urlObject = urlComponents.url {
                var urlRequest = URLRequest(url: urlObject)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "GET"
                let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                    if let respuestaDiferente = responseData {
                        if let data = try? JSONDecoder().decode(MoviesListResponse.self, from: respuestaDiferente){
                            if let movieList = data.results {
                                DispatchQueue.main.async {
                                    self.presenter?.responseFavoritesWithPresent(list: movieList)
                                }
                            }
                        }
                    }
                    if let respuestaError = responseError {
                        DispatchQueue.main.async {
                            self.presenter?.responseError(error: "\(respuestaError)", step: .getFavoritesWithPresent)
                        }
                        return
                    }
                }
                task.resume()
            }
        }
    }
}
