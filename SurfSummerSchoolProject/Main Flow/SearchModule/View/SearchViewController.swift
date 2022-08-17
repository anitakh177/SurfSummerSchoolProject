//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 05.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Constants
    
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }
    
    // MARK: - Properties
    
   var model: MainModel?
    var filteredData: [DetailItemModel] = []
    
    // MARK: - Views
    private lazy var searchBar = UISearchBar()
    private lazy var loadingErrorView = LoadingErrorView()
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var requestStackView: UIStackView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearence()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavigationBar()
        searchBar.becomeFirstResponder()
    }
    
}

// MARK: - Private Methods

private extension SearchViewController {
    
    func configureAppearence() {
        createSearchBar()
        
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
       
    }
    
    func createSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 56, y: 0, width: 300, height: 32))
        searchBar.placeholder = "Поиск"
        searchBar.layer.cornerRadius = 22
        searchBar.clipsToBounds = true
        searchBar.delegate = self
    }
    
    func configureNavigationBar() {
        let rightNavBar = UIBarButtonItem(customView: searchBar)
        navigationItem.rightBarButtonItem = rightNavBar
   
        let leftNavBar = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: navigationController, action: #selector(navigationController!.popViewController(animated:)))
        leftNavBar.tintColor = .black
        navigationItem.leftBarButtonItem = leftNavBar
        navigationController?.interactivePopGestureRecognizer?.delegate = self
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

// MARK: - UICollectionView
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
       /*  if filteredData.count == 0 {
             self.collectionView.settEmptyMessage("Nothing to show")
         } else {
             self.collectionView.restore()
         }*/
         return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        
        if let cell = cell as? MainItemCollectionViewCell {
            
            let item = filteredData[indexPath.row]
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            cell.imageUrlInString = item.imageUrlInString
            cell.didFavoriteTapped = { [weak self] in
               
                FavoritePostStorage.updateWith(favorite: item, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.filteredData[indexPath.row].isFavorite.toggle()
                        return
                    }

                }
            }
        }
        return cell
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

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
 /*   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        filteredData = []
        
        for post in model!.items {
            
            if post.title.lowercased().contains(searchBar.text!.lowercased()) {
                loadingErrorView.removeFromSuperview()
                filteredData.append(post)
                
            } else {
                loadingErrorView.isHidden = false
                self.configureLoadingErrorView()
                }
            }
        
        
        self.collectionView.reloadData()
        self.requestStackView.isHidden = true
        self.loadingErrorView.isHidden = true
    }
    */
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        for post in model!.items {
            
            if post.title.lowercased().contains(searchText.lowercased()) {
         
                filteredData.append(post)
            }
             
            }
        
        self.collectionView.reloadData()
        self.requestStackView.isHidden = true
        
    
    }
 
}

extension UICollectionView {
    func settEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
                messageLabel.text = message
                messageLabel.textColor = .black
                messageLabel.numberOfLines = 0;
                messageLabel.textAlignment = .center;
                messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
                messageLabel.sizeToFit()

                self.backgroundView = messageLabel;
            }

            func restore() {
                self.backgroundView = nil
            }
    }

