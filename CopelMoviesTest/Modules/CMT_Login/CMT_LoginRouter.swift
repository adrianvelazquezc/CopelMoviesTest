//
//  CMT_LoginRouter.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

class CMT_LoginRouter{
    var navigation: UINavigationController?
}

extension CMT_LoginRouter: CMT_LoginRouterProtocol{
    func navigateToNextView() {
        if let navigationController = self.navigation{
            let vc = CMT_MoviesMain.createModule(navigation: navigationController)
            navigationController.pushViewController(vc, animated: true )
        }
    }
}
