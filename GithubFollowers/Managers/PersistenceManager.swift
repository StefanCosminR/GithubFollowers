//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 27/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

struct PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    private init() {}
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (PersistenceManagerErrors?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var favorites = favorites
                
                switch actionType {
                case .add:
                    
                    guard !(favorites.contains { $0.login == favorite.login}) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login}
                }
                
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], PersistenceManagerErrors>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> PersistenceManagerErrors? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
        } catch {
            return .unableToFavorite
        }
        
        return nil
    }
}
