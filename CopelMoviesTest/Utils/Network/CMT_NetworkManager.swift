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
}

