//
//  UserDefaultsManager.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 26.05.2024.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let favoritesKey = "favorites"

    private init() {}

    func toggleFavorite(gameID: Int) -> Bool {
        var favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        if favorites.contains(gameID) {
            favorites.removeAll { $0 == gameID }
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
            return false
        } else {
            favorites.append(gameID)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
            return true
        }
    }

    func isFavorite(gameID: Int) -> Bool {
        let favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        return favorites.contains(gameID)
    }
}
