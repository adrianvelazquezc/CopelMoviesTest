//
//  CMT_LoginMain.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

open class CMT_LoginMain{
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        let viewController: CMT_LoginView? = CMT_LoginView()
        if let view = viewController {
            let presenter = CMT_LoginPresenter()
            let router = CMT_LoginRouter()
            let interactor = CMT_LoginInteractor()
            
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
