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
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureModel()
        model.getPosts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
   

}

// MARK: - Private Methods

private extension FavoriteViewController {
    
    func configureAppearance() {
        collectionView.register(UINib(nibName: "\(FavoriteItemCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(FavoriteItemCollectionViewCell.self)")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title =  "Избранное"
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    @objc func didTapSearch() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
}

// MARK: - UICollection

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteItemCollectionViewCell.self)", for: indexPath)
        
        if let cell = cell as? FavoriteItemCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.image = item.image
            cell.title = item.title
            cell.date = item.dateCreation
            cell.content = item.content
            cell.isFavorite = item.isFavorite
            cell.didFavoriteTapped = { [weak self] in
                self?.model.items[indexPath.row].isFavorite.toggle()
            }
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horizontalInset * 2) 
        
        return CGSize(width: itemWidth, height: 1.15 * itemWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.spaceBetweenRow
    }
    
    
    
}
