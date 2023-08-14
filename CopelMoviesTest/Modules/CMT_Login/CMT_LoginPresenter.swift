//
//  CMT_LoginPresenter.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import Foundation

class CMT_LoginPresenter {
    var interactor: CMT_LoginInteractorProtocol?
    weak var view: CMT_LoginViewProtocol?
    var router: CMT_LoginRouterProtocol?
}

extension CMT_LoginPresenter: CMT_LoginPresenterProtocol {
    func requestUserAndPassword(name: String, password: String) {
        self.view?.showLoading()
        self.interactor?.fetchToken(name: name, password: password)
    }
    
    func responseUserAndPassword() {
        self.view?.dissmissLoading()
        self.router?.navigateToNextView()
    }
    
    func responseError(error: String) {
        self.view?.dissmissLoading()
        self.view?.notifyError(error: error)
    }
}
