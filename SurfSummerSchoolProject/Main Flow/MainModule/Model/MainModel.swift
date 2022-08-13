//
//  MainModel.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 10.08.2022.
//

import Foundation
import UIKit

final class MainModel {

    // MARK: - Events

    var didItemsUpdated: (() -> Void)?

    // MARK: - Properties

    let pictureService = PicturesService()
    var items: [DetailItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }

    // MARK: - Methods

    func loadPosts(_ completion: @escaping (Bool) -> Void) {
        pictureService.loadPictures { [weak self] result in
    
            switch result {
                
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                   let result = DetailItemModel(
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: false, // TODO: - Need adding `FavoriteService`
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                    
                    return result
                    
                }
            case .failure(let error):
                // TODO: - Implement error state there
                print(error.localizedDescription)
                completion(false)
                break
            }
        }
        completion(true)
    }

}
