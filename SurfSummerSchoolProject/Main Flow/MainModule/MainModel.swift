//
//  MainModel.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 04.08.2022.
//

import Foundation
import UIKit

final class MainModel {
    
    // MARK: - Event
    
    var didItemsUpdated: (() -> Void)?
    
    // MARK: - Properties
    
    var items: [DetailItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
    
    // MARK: - Methods
    
    func getPosts() {
        items = Array(repeating: DetailItemModel.createDefault(), count: 100)
    }
    
    func addToFavorite(item: DetailItemModel) {
        items.append(item)
    }
}


