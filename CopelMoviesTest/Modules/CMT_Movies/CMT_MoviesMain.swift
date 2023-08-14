//
//  CMT_MoviesMain.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

open class CMT_MoviesMain{
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        let viewController: CMT_MoviesView? = CMT_MoviesView()
        if let view = viewController {
            let presenter = CMT_MoviesPresenter()
            let router = CMT_MoviesRouter()
            let interactor = CMT_MoviesInteractor()
            
            view.presenter = presenter
            
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
