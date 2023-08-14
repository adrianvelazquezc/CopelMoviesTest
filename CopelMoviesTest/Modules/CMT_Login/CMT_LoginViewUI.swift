//
//  CMT_LoginViewUI.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

protocol CMT_LoginViewUIDelegate {
    func notifyUserAndPassword(name: String, password: String)
}

class CMT_LoginViewUI: UIView{
    var delegate: CMT_LoginViewUIDelegate?
    var navigationController: UINavigationController?
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logoIcon")
        image.clipsToBounds = true
        return image
    }()
    
    lazy var userNameTextField : UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.text = "adrianvelazquezc"
        textfield.placeholder = "Username"
        textfield.layer.borderWidth = 0.5
        textfield.layer.cornerRadius = 10
        textfield.textColor = .black
        textfield.backgroundColor = .white
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.size.height))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        textfield.delegate = self
        return textfield
    }()
    
    lazy var userPasswordTextField : UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.text = "sU.!JEBT.j.S4Ru"
        textfield.placeholder = "Password"
        textfield.textColor = .black
        textfield.layer.borderWidth = 0.5
        textfield.layer.cornerRadius = 10
        textfield.textColor = .black
        textfield.backgroundColor = .white
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.size.height))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
        textfield.delegate = self
        return textfield
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.backgroundColor =   #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.isEnabled = false
        return button
    }()
    
    public var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor =  #colorLiteral(red: 0.7229098678, green: 0.3283879757, blue: 0.1109213307, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    public convenience init(
        navigation: UINavigationController,
        delegate: CMT_LoginViewUIDelegate){
            self.init()
            self.delegate = delegate
            self.navigationController = navigation
            
            let gestoTap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard(_:)))
            self.addGestureRecognizer(gestoTap)
            
            setUI()
            setConstraints()
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI(){
        self.backgroundColor =  #colorLiteral(red: 0.03991495073, green: 0.08235343546, blue: 0.1102337912, alpha: 1)
        self.addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(userNameTextField)
        containerView.addSubview(userPasswordTextField)
        containerView.addSubview(continueButton)
        self.addSubview(errorLabel)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            userNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            userPasswordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            userPasswordTextField.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            userPasswordTextField.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            userPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            continueButton.topAnchor.constraint(equalTo: userPasswordTextField.bottomAnchor, constant: 50),
            continueButton.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            errorLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),
        ])
    }
    
    @objc func dissmisKeyboard(_ sender: UITapGestureRecognizer){
        self.endEditing(true)
    }
    @objc func buttonTapped(_ sender: UITapGestureRecognizer) {
        self.delegate?.notifyUserAndPassword(name: userNameTextField.text ?? "", password: userPasswordTextField.text ?? "")
    }
}

extension CMT_LoginViewUI: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        continueButton.isEnabled = (!(userNameTextField.text?.isEmpty ?? false) && !(userPasswordTextField.text?.isEmpty ?? false))
        if continueButton.isEnabled {
            continueButton.backgroundColor =   #colorLiteral(red: 0.4548825622, green: 0.8329617977, blue: 0.4634124041, alpha: 1)
        } else {
            continueButton.backgroundColor =   #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
