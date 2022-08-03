//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Избранное"
        navigationButton()
        // Do any additional setup after loading the view.
    }
    private func navigationButton() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    @objc func didTapSearch() {
        print("tapped search")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
