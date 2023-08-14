//
//  CMT_LoginView.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

class CMT_LoginView: UIViewController {
    var presenter: CMT_LoginPresenterProtocol?
    private var ui: CMT_LoginViewUI?
    private var tempName = ""
    private var tempPassword = ""
    
    override func loadView() {
        ui = CMT_LoginViewUI(
            navigation: self.navigationController ?? UINavigationController(),
            delegate: self
        )
        view = ui
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ui?.errorLabel.isHidden = true
    }
}

extension CMT_LoginView: CMT_LoginViewProtocol {
    
    func notifyError(error: String) {
        ui?.errorLabel.isHidden = false
        ui?.errorLabel.text = error
    }
    
    func showLoading() {
        CMT_ActivityIndicator.show(parent: self.view)
    }
    
    func dissmissLoading() {
        CMT_ActivityIndicator.remove(parent: self.view)
    }
}

extension CMT_LoginView: CMT_LoginViewUIDelegate {
    
    func notifyUserAndPassword(name: String, password: String) {
        self.tempName = name
        self.tempPassword = password
        self.presenter?.requestUserAndPassword(name: name, password: password)
    }
    
}
