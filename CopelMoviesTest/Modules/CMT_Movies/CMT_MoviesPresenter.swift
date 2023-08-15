//
//  CMT_MoviesPresenter.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import Foundation

class CMT_MoviesPresenter {
    var interactor: CMT_MoviesInteractorProtocol?
    weak var view: CMT_MoviesViewProtocol?
    var router: CMT_MoviesRouterProtocol?
    var favorites: [Pelicula] = []
    var currentGender: MoviesCategories?
}



extension CMT_MoviesPresenter: CMT_MoviesPresenterProtocol {
    func requestMovieList(gender: MoviesCategories) {
        self.view?.showLoading()
        self.interactor?.fetchMovieList(gender: gender)
    }
    
    func responseMovieList(_ list: [Pelicula]) {
        self.view?.dissmissLoading()
        var favoriteMovieIDs: Set<Int> = []
        for favorite in self.favorites {
            favoriteMovieIDs.insert(favorite.id ?? 0)
        }
        view?.notifyMovieList(list: list, favoriteList: self.favorites, favoriteMovieIDs: favoriteMovieIDs)
    }
    
    func requestMoviesDetails(movieId: Int, isFavoriteMovie: Bool) {
        self.router?.navigateMovieDetails(movieId: movieId, isFavoriteMovie: isFavoriteMovie)
    }
    
    func requestFavoriteList() {
        self.view?.showLoading()
        self.interactor?.fetchFavoriteListMovies()
    }
    
    func responseFavoriteList(list: [Pelicula]) {
        self.favorites = list
        self.view?.notifyFavoriteList()
    }
    
    func requestDeleteSession() {
        self.view?.showLoading()
        self.interactor?.postDeleteSession()
    }
    
    func responseDeletedSession() {
        self.view?.dissmissLoading()
        self.router?.navigateCloseSession()
    }
    
    func requestFavoriteMovie(isFavorite: Bool, movieId: Int) {
        self.view?.showLoading()
        self.interactor?.fetchFavoriteMovie(isFavorite: isFavorite, movieId: movieId)
    }
    
    func responseFavoriteMovie() {
        self.view?.dissmissLoading()
        self.view?.notifyAddDeleteFavoriteList()
    }
    
    func requestFavoritesWithPresent() {
        self.view?.showLoading()
        self.interactor?.fetchFavoritesWithPresent()
    }
    
    func responseFavoritesWithPresent(list: [Pelicula]) {
        self.view?.dissmissLoading()
        self.view?.notifyShowProfile(list: list)
    }
    
    func responseError(error: String, step: ListService) {
        self.view?.dissmissLoading()
        self.view?.notifyError(error: error, step: step)
    }
}
