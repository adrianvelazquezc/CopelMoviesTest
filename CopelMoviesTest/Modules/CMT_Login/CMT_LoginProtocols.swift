//
//  CMT_LoginProtocols.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import Foundation

protocol CMT_LoginViewProtocol: AnyObject {
    func notifyError(error: String)
    func showLoading()
    func dissmissLoading()
}

protocol CMT_LoginInteractorProtocol: AnyObject {
    func fetchToken(name: String, password: String)
    func fetchUserAndPassword(name: String, password: String)
    func authenticateToken()
}

protocol CMT_LoginPresenterProtocol: AnyObject {
    func requestUserAndPassword(name: String, password: String)
    func responseUserAndPassword()
    func responseError(error: String)
}

protocol CMT_LoginRouterProtocol: AnyObject {
    func navigateToNextView()
}
