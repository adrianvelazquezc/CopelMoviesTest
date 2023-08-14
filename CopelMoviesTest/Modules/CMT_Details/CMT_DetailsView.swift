//
//  CMT_DetailsView.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

class CMT_DetailsView: UIViewController {
    var presenter: CMT_DetailsPresenterProtocol?
    private var ui: CMT_DetailsViewUI?
    internal var movieID: Int = 0
    internal var isFavoriteMovie = false
    
    override func loadView() {
        ui = CMT_DetailsViewUI(
            navigation: self.navigationController ?? UINavigationController(),
            delegate: self,
            movieId: self.movieID,
            isFavoriteMovie: isFavoriteMovie
        )
        view = ui
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.requestMovieDetails(movieId: self.movieID)
    }
}

extension CMT_DetailsView: CMT_DetailsViewProtocol {
    func notifyShowProfile(list: [Pelicula]) {
        let profileController = CMT_ProfilePresent()
        profileController.movieList = list
        profileController.delegate = self
        self.present(profileController, animated: true, completion: nil)
    }
    
    func notifyMovieDetails(movieDetails: MovieDetails) {
        ui?.updateValues(movieDetails: movieDetails, isFavorite: isFavoriteMovie)
    }
    
    func notifyError(error: String, step: ListService) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: { action in
            switch step {
            case .getmoviesList:
                break
            case .getFavoritesMovies:
                break
            case .updateFavoriteMovie:
                self.presenter?.requestFavoriteMovie(isFavorite: self.isFavoriteMovie, movieId: self.movieID)
                break
            case .deleteSession:
                self.presenter?.requestDeleteSession()
                break
            case .getmovieDetails:
                self.presenter?.requestMovieDetails(movieId: self.movieID)
                break
            case .getFavoritesWithPresent:
                break
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        CMT_ActivityIndicator.show(parent: self.view)
    }
    
    func dissmissLoading() {
        CMT_ActivityIndicator.remove(parent: self.view)
    }
    
}

extension CMT_DetailsView: CMT_DetailsViewUIDelegate {
    func notifyMenuPressed() {
        let alertController = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "View Profile", style: .default) { _ in
            self.presenter?.requestFavoritesWithPresent()
        }
        alertController.addAction(action1)
        let action2 = UIAlertAction(title: "Log out", style: .destructive) { _ in
            self.presenter?.requestDeleteSession()
        }
        alertController.addAction(action2)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func notifyBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func notifyUpdateFavorite(isFavorite: Bool, movieId: Int) {
        self.isFavoriteMovie = isFavorite
        self.presenter?.requestFavoriteMovie(isFavorite: isFavorite, movieId: movieId)
    }
}

extension CMT_DetailsView: CMT_ProfilePresentDelegate {
    func willDissmiss(deletedId: Set<Int>) {
        if deletedId.contains(self.movieID) {
            
            ui?.favoriteButton.tintColor = .white
            ui?.favoriteButton.setImage(UIImage(named: "favoriteIcon"), for: .normal)
        }
        self.presenter?.requestMovieDetails(movieId: self.movieID)
    }
}
