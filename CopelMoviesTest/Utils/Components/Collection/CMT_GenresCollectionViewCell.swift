//
//  CMT_GenresCollectionViewCell.swift
//  CopelMoviesTest
//
//  Created by Mac on 12/08/23.
//

import UIKit

class CMT_GenresCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CMT_GenresCollectionViewCell"
    
    private var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor =  #colorLiteral(red: 0.106094636, green: 0.1726573706, blue: 0.2030406594, alpha: 1)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var genresTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  #colorLiteral(red: 0.4548825622, green: 0.8329617977, blue: 0.4634124041, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public convenience init(){
        self.init()
    }
    
    fileprivate func setupUIElements() {
        self.backgroundColor = .clear
        self.addSubview(mainContainer)
        mainContainer.addSubview(genresTitleLabel)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            self.mainContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.mainContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            self.genresTitleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 10),
            self.genresTitleLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            self.genresTitleLabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            self.genresTitleLabel.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -10),
        ])
    }
}

