//
//  CMT_NavigationBar.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

public protocol CMT_NavigationBarDelegate {
    func buttonTapped()
    func backTapped()
}

open class CMT_NavigationBar: UIView {
    
    var delegate: CMT_NavigationBarDelegate?
    
    lazy private var navigationTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 7))
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "menuIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 7))
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "arrowBackIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.backTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUI()
        setConstraints()
    }
    
    public func buildComponents(titleText: String, textColor: UIColor = .white, delegate: CMT_NavigationBarDelegate, backDisabled: Bool = true) {
        self.delegate = delegate
        navigationTitle.text = titleText
        navigationTitle.textColor = textColor
        backButton.isHidden = backDisabled
        backButton.isUserInteractionEnabled = !backDisabled
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.backgroundColor =  #colorLiteral(red: 0.215639472, green: 0.2463306785, blue: 0.2608401179, alpha: 1)
        self.addSubview(navigationTitle)
        self.addSubview(menuButton)
        self.addSubview(backButton)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 80),
            
            navigationTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            navigationTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            menuButton.centerYAnchor.constraint(equalTo: navigationTitle.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 15),
            menuButton.heightAnchor.constraint(equalToConstant: 15),
            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            backButton.centerYAnchor.constraint(equalTo: navigationTitle.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 15),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton){
        delegate?.buttonTapped()
    }
    
    @objc private func backTapped(_ sender: UIButton){
        delegate?.backTapped()
    }
}
