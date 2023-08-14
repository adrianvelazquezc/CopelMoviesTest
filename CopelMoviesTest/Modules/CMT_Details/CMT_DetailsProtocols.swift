//
//  CMT_DetailsProtocols.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import Foundation

protocol CMT_DetailsViewProtocol: AnyObject {
    func notifyMovieDetails(movieDetails: MovieDetails)
    func notifyError(error: String, step: ListService)
    func showLoading()
    func dissmissLoading()
    func notifyShowProfile(list: [Pelicula])
}

protocol CMT_DetailsInteractorProtocol: AnyObject {
    func fetchMovieDetails(movieId: Int)
    func fetchFavoriteMovie(isFavorite: Bool, movieId: Int)
    func postDeleteSession()
    func fetchFavoritesWithPresent()
}

protocol CMT_DetailsPresenterProtocol: AnyObject {
    func requestMovieDetails(movieId: Int)
    func responseMovieDetails(movieDetails: MovieDetails)
    func requestFavoriteMovie(isFavorite: Bool, movieId: Int)
    func responseFavoriteMovie()
    func requestDeleteSession()
    func responseDeletedSession()
    func requestFavoritesWithPresent()
    func responseFavoritesWithPresent(list: [Pelicula])
    func responseError(error: String, step: ListService)
}

protocol CMT_DetailsRouterProtocol: AnyObject {
    func navigateCloseSession()
}
