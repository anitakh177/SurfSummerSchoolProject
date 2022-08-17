//
//  FavoritePostModel.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 13.08.2022.
//

import Foundation

struct FavoritePostModel: Codable {

    // MARK: - Internal Properties

    let id: String
    let title: String
    let content: String
    let photoUrl: String

    var date: Date {
        Date(timeIntervalSince1970: publicationDate / 1000)
    }

    // MARK: - Private Properties

    private let publicationDate: Double

}
