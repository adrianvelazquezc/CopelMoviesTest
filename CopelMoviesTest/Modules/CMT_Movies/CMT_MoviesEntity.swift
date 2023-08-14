//
//  CMT_MoviesEntity.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import Foundation

public enum ListService {
    case getmoviesList
    case getFavoritesMovies
    case updateFavoriteMovie
    case deleteSession
    case getmovieDetails
    case getFavoritesWithPresent
}
struct MoviesListResponse: Codable {
    let page: Int?
    let results: [Pelicula]?
    let total_pages: Int?
    let total_results: Int?
    
}
public struct Pelicula: Codable{
    let id: Int?
    let title: String?
    let urlPic: String?
    let date: String?
    let over: String?
    let average: Float?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case title = "title"
        case urlPic = "poster_path"
        case date = "release_date"
        case over = "overview"
        case average = "vote_average"
    }
}

public enum MoviesCategories {
    case popular
    case top_rated
    case upcoming
    case now_playing
}

public struct LogoutResponse: Codable {
    var success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}
