//
//  CMT_DetailsMain.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

open class CMT_DetailsMain{
    public static func createModule(navigation: UINavigationController, movieId: Int, isFavoriteMovie: Bool) -> UIViewController {
        let viewController: CMT_DetailsView? = CMT_DetailsView()
        if let view = viewController {
            let presenter = CMT_DetailsPresenter()
            let router = CMT_DetailsRouter()
            let interactor = CMT_DetailsInteractor()
            
            view.presenter = presenter
            view.movieID = movieId
            view.isFavoriteMovie = isFavoriteMovie
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            
            router.navigation = navigation
            
            interactor.presenter = presenter
            return view
        }
        return UIViewController()
    }
}
