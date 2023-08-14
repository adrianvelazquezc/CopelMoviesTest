//
//  CMT_MoviesRouter.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

class CMT_MoviesRouter{
    var navigation: UINavigationController?
}

extension CMT_MoviesRouter: CMT_MoviesRouterProtocol{
    func navigateCloseSession() {
        self.navigation?.popToRootViewController(animated: true)
    }
    
    func navigateMovieDetails(movieId: Int, isFavoriteMovie: Bool) {
        if let navigationController = self.navigation{
            let vc = CMT_DetailsMain.createModule(navigation: navigationController, movieId: movieId, isFavoriteMovie: isFavoriteMovie)
            navigationController.pushViewController(vc, animated: true )
        }
    }
}
