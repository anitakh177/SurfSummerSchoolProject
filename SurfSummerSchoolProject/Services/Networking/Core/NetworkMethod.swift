//
//  NetworkMethod.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 10.08.2022.
//

import Foundation

enum NetworkMethod: String {

    case get
    case post

}

extension NetworkMethod {

    var method: String {
        rawValue.uppercased()
    }

}
