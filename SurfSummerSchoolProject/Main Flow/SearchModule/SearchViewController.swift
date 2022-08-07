//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 05.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Views
    
    private lazy var searchBar = UISearchBar()

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
    }
    
    func createSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 56, y: 0, width: 300, height: 32))
        searchBar.placeholder = "Поиск"
        searchBar.layer.cornerRadius = 22
        searchBar.clipsToBounds = true
    }
    
    func configureNavigationBar() {
        let rightNavBar = UIBarButtonItem(customView: searchBar)
        navigationItem.rightBarButtonItem = rightNavBar
   
        let leftNavBar = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: navigationController, action: #selector(navigationController!.popViewController(animated:)))
        leftNavBar.tintColor = .black
        navigationItem.leftBarButtonItem = leftNavBar
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    
    
}
