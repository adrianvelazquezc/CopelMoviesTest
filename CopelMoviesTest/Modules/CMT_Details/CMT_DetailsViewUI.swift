//
//  CMT_DetailsViewUI.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

protocol CMT_DetailsViewUIDelegate {
    func notifyBackTapped()
    func notifyMenuPressed()
    func notifyUpdateFavorite(isFavorite: Bool, movieId: Int)
}

class CMT_DetailsViewUI: UIView{
    var delegate: CMT_DetailsViewUIDelegate?
    var navigationController: UINavigationController?
    var genresData: [String] = []
    var movieId = 0
    var companysData: [MovieDetails.ProductionCompany] = []
    
    var isFavorite = false {
        didSet {
            if isFavorite{
                favoriteButton.tintColor = .red
                favoriteButton.setImage(UIImage(named: "favoriteFilledIcon"), for: .normal)
            }else{
                favoriteButton.tintColor = .white
                favoriteButton.setImage(UIImage(named: "favoriteIcon"), for: .normal)
            }
        }
    }
    
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy private var navigationBar: CMT_NavigationBar = {
        let navigationBar = CMT_NavigationBar()
        navigationBar.buildComponents(titleText: "TV Shows", delegate: self, backDisabled: false)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let movieReleasedateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var starPicture: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = #colorLiteral(red: 0.4548825622, green: 0.8329617977, blue: 0.4634124041, alpha: 1)
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "star.fill")
        return image
    }()
    
    let movieAverageVoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieVotesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.attributedText = getLabelText(text: "Score:", font: .systemFont(ofSize: 20, weight: .bold))
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieVotesCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieGenresLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.attributedText = getLabelText(text: "Generes:", font: .systemFont(ofSize: 20, weight: .bold))
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieProductionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var moviePosterPicture: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy public var favoriteButton: UIButton = {
        let button = UIButton(frame:.zero)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.favoriteTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 10) / 2.5, height: 70)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CMT_GenresCollectionViewCell.self, forCellWithReuseIdentifier: CMT_GenresCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor =  #colorLiteral(red: 0.03991495073, green: 0.08235343546, blue: 0.1102337912, alpha: 1)
        collectionView.tag = 0
        return collectionView
    }()
    
    lazy var companyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CMT_CompanysCollectionViewCell.self, forCellWithReuseIdentifier: CMT_CompanysCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor =  #colorLiteral(red: 0.03991495073, green: 0.08235343546, blue: 0.1102337912, alpha: 1)
        collectionView.tag = 1
        return collectionView
    }()
    
    public convenience init(
        navigation: UINavigationController,
        delegate: CMT_DetailsViewUIDelegate,
        movieId: Int,
        isFavoriteMovie: Bool){
            self.init()
            self.delegate = delegate
            self.navigationController = navigation
            self.movieId = movieId
            self.isFavorite = isFavoriteMovie
            
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
        self.addSubview(navigationBar)
        self.addSubview(scrollView)
        scrollView.addSubview(movieTitleLabel)
        scrollView.addSubview(moviePosterPicture)
        scrollView.addSubview(favoriteButton)
        scrollView.addSubview(movieOverviewLabel)
        scrollView.addSubview(movieReleasedateLabel)
        scrollView.addSubview(starPicture)
        scrollView.addSubview(movieAverageVoteLabel)
        scrollView.addSubview(movieVotesLabel)
        scrollView.addSubview(movieVotesCountLabel)
        scrollView.addSubview(movieGenresLabel)
        scrollView.addSubview(movieProductionLabel)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(companyCollection)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            moviePosterPicture.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            moviePosterPicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            moviePosterPicture.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            moviePosterPicture.heightAnchor.constraint(equalToConstant: 400),
            
            favoriteButton.topAnchor.constraint(equalTo: moviePosterPicture.topAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: moviePosterPicture.trailingAnchor, constant: -10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            
            movieTitleLabel.topAnchor.constraint(equalTo: moviePosterPicture.bottomAnchor, constant: 10),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            movieReleasedateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            movieReleasedateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieReleasedateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            movieOverviewLabel.topAnchor.constraint(equalTo: movieReleasedateLabel.bottomAnchor, constant: 10),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            movieVotesLabel.topAnchor.constraint(equalTo: movieOverviewLabel.bottomAnchor, constant: 10),
            movieVotesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieVotesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            movieAverageVoteLabel.topAnchor.constraint(equalTo: movieVotesLabel.bottomAnchor, constant: 10),
            movieAverageVoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            movieAverageVoteLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            
            starPicture.centerYAnchor.constraint(equalTo: movieAverageVoteLabel.centerYAnchor),
            starPicture.heightAnchor.constraint(equalToConstant: 10),
            starPicture.widthAnchor.constraint(equalToConstant: 10),
            starPicture.trailingAnchor.constraint(equalTo: movieAverageVoteLabel.leadingAnchor, constant: -5),
            
            movieVotesCountLabel.topAnchor.constraint(equalTo: movieAverageVoteLabel.topAnchor),
            movieVotesCountLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 20),
            movieVotesCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            movieProductionLabel.topAnchor.constraint(equalTo: movieVotesCountLabel.bottomAnchor, constant: 10),
            movieProductionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieProductionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            movieGenresLabel.topAnchor.constraint(equalTo: movieProductionLabel.bottomAnchor, constant: 10),
            movieGenresLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            movieGenresLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: movieGenresLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            companyCollection.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            companyCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            companyCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            companyCollection.heightAnchor.constraint(equalToConstant: 150),
            companyCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
    
    @objc func favoriteTapped(_ sender: UITapGestureRecognizer){
        self.isFavorite = !isFavorite
        self.delegate?.notifyUpdateFavorite(isFavorite: isFavorite, movieId: movieId)
    }
    
    public func updateValues(movieDetails: MovieDetails, isFavorite: Bool) {
        self.isFavorite = isFavorite
        DispatchQueue.main.async {
            self.movieTitleLabel.attributedText = getLabelText(text: movieDetails.title ?? "", font: .systemFont(ofSize: 25, weight: .bold))
            self.movieOverviewLabel.attributedText = getLabelText(text: movieDetails.overview ?? "")
            let newDate = parseDate(movieDetails.releaseDate ?? "", oldDateFormat: "yyyy-MM-dd")
            self.movieReleasedateLabel.attributedText = getLabelText(text: newDate)
            if let averange = movieDetails.averageVote {
                
                let formattedString = String(format: "%.1f", averange)
                self.movieAverageVoteLabel.attributedText = getLabelText(text: formattedString)
            }
            if let votesCounter = movieDetails.countVote {
                self.movieVotesCountLabel.attributedText = getLabelText(text: "Votes: \(votesCounter)")
            }
            
            if let productionCompanies = movieDetails.genres {
                for company in productionCompanies {
                    self.genresData.append(company.name ?? "")
                }
            }
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
            if let companyInfo = movieDetails.productionCompanies {
                self.companysData = companyInfo
                self.companyCollection.reloadData()
                self.companyCollection.layoutIfNeeded()
            }
        }
        if let url = URL(string: CMT_NetworkManager.shared.firstURL + (movieDetails.posterPath ?? "")) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.moviePosterPicture.image = image
                    }
                }
            }
            task.resume()
        }
    }
}

extension CMT_DetailsViewUI: CMT_NavigationBarDelegate {
    func backTapped() {
        delegate?.notifyBackTapped()
    }
    
    func buttonTapped() {
        delegate?.notifyMenuPressed()
    }
}


extension CMT_DetailsViewUI: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return genresData.count
        }else if collectionView.tag == 1 {
            return companysData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMT_GenresCollectionViewCell.identifier, for: indexPath) as? CMT_GenresCollectionViewCell {
                cell.genresTitleLabel.text = genresData[indexPath.row]
                return cell
            }
        }else if collectionView.tag == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMT_CompanysCollectionViewCell.identifier, for: indexPath) as? CMT_CompanysCollectionViewCell {
                cell.companysLabel.text = companysData[indexPath.row].name
                if let url = URL(string: CMT_NetworkManager.shared.firstURL + (companysData[indexPath.row].logoPath ?? "") ) {
                    let session = URLSession.shared
                    let task = session.dataTask(with: url) { (data, response, error) in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.companyImageView.image = image
                                cell.companyImageView.isHidden = false
                                cell.companysLabel.isHidden = true
                            }
                        }
                    }
                    task.resume()
                }
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
}
