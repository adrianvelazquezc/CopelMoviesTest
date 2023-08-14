//
//  CMT_ProfilePresent.swift
//  CopelMoviesTest
//
//  Created by Mac on 11/08/23.
//

import UIKit

protocol CMT_ProfilePresentDelegate {
    func willDissmiss(deletedId: Set<Int>)
}
class CMT_ProfilePresent: UIViewController {
    var delegate: CMT_ProfilePresentDelegate?
    public var movieList: [Pelicula]? {
        didSet{
            if movieList?.count == 0 {
                self.emptyArrayLabel.isHidden = true
            }else{
                self.emptyArrayLabel.isHidden = true
            }
        }
    }
    
    var deletedIDs: Set<Int> = []
    
    public var currentId = 0
    
    private lazy var mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Profile", attributes: [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4548825622, green: 0.8329617977, blue: 0.4634124041, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)
        ])
        label.attributedText = attributedString
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var profilePicture: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "profileIcon")
        image.clipsToBounds = true
        return image
    }()
    
    public lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@\(CMT_NetworkManager.shared.userName)"
        label.textColor =  #colorLiteral(red: 0.4548825622, green: 0.8329617977, blue: 0.4634124041, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var favoriteLabel: UILabel = {
        let label = UILabel()
        label.attributedText = getLabelText(text: "Favorite Shows", font: .systemFont(ofSize: 20, weight: .bold))
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyArrayLabel: UILabel = {
        let label = UILabel()
        label.attributedText = getLabelText(text: "No favorite movies added", font: .systemFont(ofSize: 30, weight: .bold))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 10) / 1.8, height: UIScreen.main.bounds.height < 667 ? (UIScreen.main.bounds.height / 2.0) : 340)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CMT_CollectionViewCell.self, forCellWithReuseIdentifier: CMT_CollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor =  #colorLiteral(red: 0.03991495073, green: 0.08235343546, blue: 0.1102337912, alpha: 1)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.willDissmiss(deletedId: self.deletedIDs)
    }
    
    func setUI(){
        view.backgroundColor =  #colorLiteral(red: 0.03991495073, green: 0.08235343546, blue: 0.1102337912, alpha: 1)
        view.addSubview(mainContainer)
        mainContainer.addSubview(titleLabel)
        mainContainer.addSubview(profilePicture)
        mainContainer.addSubview(profileNameLabel)
        mainContainer.addSubview(favoriteLabel)
        mainContainer.addSubview(collectionView)
        mainContainer.addSubview(emptyArrayLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            mainContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: UIScreen.main.bounds.height <= 667 ? -10 : -40),
            
            titleLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            
            profilePicture.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            profilePicture.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 40),
            profilePicture.widthAnchor.constraint(equalToConstant: 130),
            profilePicture.heightAnchor.constraint(equalToConstant: 130),
            
            profileNameLabel.centerYAnchor.constraint(equalTo: profilePicture.centerYAnchor),
            profileNameLabel.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 30),
            
            favoriteLabel.centerYAnchor.constraint(equalTo: mainContainer.centerYAnchor, constant: UIScreen.main.bounds.height <= 667 ? -50 : 0),
            favoriteLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor, constant: UIScreen.main.bounds.height <= 667 ? 0 : 30),
            collectionView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
            
            emptyArrayLabel.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor, constant: UIScreen.main.bounds.height <= 667 ? 30 : 30),
            emptyArrayLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 20),
            emptyArrayLabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -20),
        ])
    }

    
    func deleteFavorite(completionHandler:@escaping(PeliculaLogin?,Int?,Error?)->Void){
        let urlString = "\(CMT_NetworkManager.shared.initialPath)account/\(CMT_NetworkManager.shared.userName)/favorite?api_key=\(CMT_NetworkManager.shared.apiKey)&session_id=\(CMT_NetworkManager.shared.sesionID)"
        
        if let urlObject = URL(string: urlString){
            var urlRequest = URLRequest(url: urlObject)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "POST"
            let body: [String: Any] = [
                "media_type": "movie",
                "media_id": currentId,
                "favorite": false
            ]
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                completionHandler(nil, nil, "error al convertir el json" as? Error)
                return
            }
            
            urlRequest.httpBody = httpBody
            
            let task = URLSession.shared.dataTask(with: urlRequest) { responseData, responseCode, responseError in
                if let auxResponse = responseCode as? HTTPURLResponse {
                    let _ = auxResponse.statusCode
                }
                guard let respuestaDiferente = responseData else {
                    completionHandler(nil, responseCode.hashValue, responseError)
                    return
                }
                if let json = try? JSONDecoder().decode(PeliculaLogin.self, from: respuestaDiferente){
                    completionHandler(json,200,nil)
                }
            }
            task.resume()
        }
    }
}

extension CMT_ProfilePresent: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMT_CollectionViewCell.identifier, for: indexPath) as? CMT_CollectionViewCell {
            if let list = movieList?[indexPath.row] {
                cell.favoriteButton.tintColor = .red
                cell.favoriteButton.isUserInteractionEnabled = false
                cell.favoriteButton.setImage(UIImage(named: "favoriteFilledIcon"), for: .normal)
                if let url = URL(string: CMT_NetworkManager.shared.firstURL + (list.urlPic ?? "")) {
                    let session = URLSession.shared
                    let task = session.dataTask(with: url) { (data, response, error) in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.posterPicture.image = image
                            }
                        }
                    }
                    task.resume()
                }
                cell.titleLabel.text = list.title
                cell.dateLabel.text = parseDate(list.date ?? "", oldDateFormat: "yyyy-MM-dd")
                if let averange = list.average {
                    let formattedString = String(format: "%.1f", averange)
                    cell.averangeLabel.text = "\(formattedString)"
                }
                cell.resumeLabel.text = list.over
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let newId = movieList?[indexPath.row].id {
            self.currentId = newId
            self.deleteFavorite { responseList, responseCode, responseError in
                if let _ = responseList {
                    DispatchQueue.main.async {
                        self.deletedIDs.insert(self.movieList?[indexPath.row].id ?? 0)
                        self.movieList?.remove(at: indexPath.row)
                        collectionView.reloadData()
                        collectionView.layoutIfNeeded()
                        collectionView.layoutSubviews()
                    }
                }
            }
        }
    }
}
