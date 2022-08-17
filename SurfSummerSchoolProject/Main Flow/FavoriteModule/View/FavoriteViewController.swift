//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let spaceBetweenRow: CGFloat = 24
    }
    
   
    // MARK: - Private Properties
    
    private let model: MainModel = .init()
    
    private var favorites: [DetailItemModel] = []
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private lazy var emptyStateLabel = UILabel()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        getFavoritePosts()
    }
   

}

// MARK: - Private Methods

private extension FavoriteViewController {
    
    func getFavoritePosts() {
        FavoritePostStorage.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                
                if favorites.isEmpty {
                    DispatchQueue.main.async {
                        self.configureEmptyView()
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.emptyStateLabel.isHidden = true
                        self?.collectionView.reloadData()
                }
                }
            case .failure(let error):
                break
            }
        }
    }
    
    func configureAppearance() {
        collectionView.register(UINib(nibName: "\(FavoriteItemCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(FavoriteItemCollectionViewCell.self)")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configureNavigationBar() {
        navigationItem.title =  "Избранное"
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    @objc func didTapSearch() {
        let searchVC = SearchViewController()
        let mainVC = MainViewController()
        searchVC.model = mainVC.model
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func configureDeleteAlert(indexPath: IndexPath) {
        let message = UIAlertController(title: "Внимание", message: "Вы точно хотите удлить\nиз избранного?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Да, точно", style: .default, handler: { (action) -> Void in
            let favorite = self.favorites[indexPath.row]
            self.favorites.remove(at: indexPath.row)
            self.collectionView.deleteItems(at: [indexPath])
            
            FavoritePostStorage.updateWith(favorite: favorite, actionType: .remove) { error in
                guard let error = error else {
                    return
                }

            }
            
        })
        let cancel = UIAlertAction(title: "Нет", style: .cancel)
        
        message.addAction(ok)
        message.addAction(cancel)
        self.present(message, animated: true)
    }
    
    func configureEmptyView() {
        emptyStateLabel = UILabel()
       // emptyStateLabel.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 )
        emptyStateLabel.text = "Пока что пусто\n Добавьте в избранное любимые посты"
        emptyStateLabel.textColor = .lightGray
        emptyStateLabel.font = .systemFont(ofSize: 14)
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.numberOfLines = 0
        
        view.addSubview(emptyStateLabel)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyStateLabel.heightAnchor.constraint(equalToConstant: 40),
            emptyStateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emptyStateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyStateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250)
            
        
        ])
    }
    
}

// MARK: - UICollection

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteItemCollectionViewCell.self)", for: indexPath)
        
        if let cell = cell as? FavoriteItemCollectionViewCell {
            let item = favorites[indexPath.row]
            cell.imageUrlInString = item.imageUrlInString
            cell.title = item.title
            cell.date = item.dateCreation
            cell.content = item.content
            cell.isFavorite = item.isFavorite
            cell.didFavoriteTapped = { [weak self] in
               // self?.model.items[indexPath.row].isFavorite.toggle()
                self?.configureDeleteAlert(indexPath: indexPath)
            }
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.model = favorite
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horizontalInset * 2) 
        
        return CGSize(width: itemWidth, height: 1.15 * itemWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.spaceBetweenRow
    }
    
    
    
}
