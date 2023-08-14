//
//  CMT_CompanysCollectionViewCell.swift
//  CopelMoviesTest
//
//  Created by Mac on 12/08/23.
//

import UIKit

class CMT_CompanysCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CMT_CompanysCollectionViewCell"
    
    private var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor =  #colorLiteral(red: 0.106094636, green: 0.1726573706, blue: 0.2030406594, alpha: 1)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var companysLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.attributedText = getLabelText(text: "Generes:", font: .systemFont(ofSize: 16, weight: .regular))
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var companyImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logoIcon")
        image.clipsToBounds = true
        image.isHidden = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 75
        self.clipsToBounds = true
        self.layer.borderColor =  #colorLiteral(red: 0.4548825622, green: 0.8329617977, blue: 0.4634124041, alpha: 1)
        self.layer.borderWidth = 3
        
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
        mainContainer.addSubview(companysLabel)
        mainContainer.addSubview(companyImageView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            self.mainContainer.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            companysLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 10),
            companysLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 10),
            companysLabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -10),
            companysLabel.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -10),
            
            companyImageView.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 35),
            companyImageView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 35),
            companyImageView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -35),
            companyImageView.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -35),
        ])
    }
}

