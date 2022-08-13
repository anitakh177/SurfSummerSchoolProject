//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }
    
    // MARK: - Private Properties
    
    private let model: MainModel = .init()
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var activityIndicator = UIActivityIndicatorView()
    private var loadingErrorView = LoadingErrorView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearence()
        configureModel()
        getPosts()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigationBar()
    }
    
}

// MARK: - Private Methods

private extension MainViewController {
    func getPosts() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.model.loadPosts { isDone in
                if isDone == true {
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.configureLoadingErrorView()
                    }
                }
            }
        }
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            self?.collectionView.reloadData()
           }
        }
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func didTapSearch() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    func configureAppearence() {
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        configureActivityIndicator()
    }
    
    func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 )
        activityIndicator.hidesWhenStopped = true
    }
    
   func configureLoadingErrorView() {
    
        view.addSubview(loadingErrorView)
        loadingErrorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingErrorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            loadingErrorView.widthAnchor.constraint(equalTo: view.widthAnchor),
            loadingErrorView.heightAnchor.constraint(equalToConstant: 153)
        
        ])
    }
    
}
// MARK: - UICollection

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.imageUrlInString = item.imageUrlInString
            cell.didFavoriteTapped = { [weak self] in
                self?.model.items[indexPath.row].isFavorite.toggle()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.model = model.items[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horizontalInset * 2 - Constants.spaceBetweenElements) / 2
        return CGSize(width: itemWidth, height: 1.46 * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements
    }
    
    
}
