//
//  FavoritePostPersistence.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 13.08.2022.
//

import Foundation


enum FavoritePostStorage {
    enum SaveError: Error {
        case unbaleToFav
    }
    
   static private let defaults = UserDefaults.standard

   static func retrieveFavorites(completion: @escaping (Result<[DetailItemModel], Error>) -> Void) {
        guard let favoriteData = defaults.object(forKey: "favorites") as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([DetailItemModel].self, from: favoriteData)
            completion(.success(favorites))
        } catch {
            completion(.failure(error.localizedDescription as! Error))
        }
    }
    
   static func save(favorites: [DetailItemModel]) -> Error? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: "favorites")
            return nil
        } catch {
            return SaveError.unbaleToFav
        }
    }
    
   static func updateWith(favorite: DetailItemModel, actionType: StorageActionType, completion: @escaping (Error?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                var favorite = favorite
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(where: {$0.title == favorite.title}) else {
                        completion(nil)
                        return
                    }
                    
                    favorite.isFavorite = true
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    favorite.isFavorite = false
                    retrievedFavorites.removeAll { $0.title == favorite.title }

                }
                completion(save(favorites:retrievedFavorites))
                
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}

enum StorageActionType {
    case add, remove
}


