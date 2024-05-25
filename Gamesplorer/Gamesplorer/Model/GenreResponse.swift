//
//  GenreResponse.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 25.05.2024.
//

import Foundation

struct GenreResponse: Decodable {
    let results: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
    let slug: String
    let games_count: Int
    let image_background: String?
}
