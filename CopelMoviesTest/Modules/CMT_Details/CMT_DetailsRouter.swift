//
//  CMT_DetailsRouter.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

class CMT_DetailsRouter{
    var navigation: UINavigationController?
}

extension CMT_DetailsRouter: CMT_DetailsRouterProtocol{
    func navigateCloseSession() {
        self.navigation?.popToRootViewController(animated: true)
    }
}
