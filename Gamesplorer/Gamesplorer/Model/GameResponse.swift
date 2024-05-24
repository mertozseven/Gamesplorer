//
//  GameResponse.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 20.05.2024.
//

import Foundation

struct GameResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Game]
}

struct Game: Decodable {
    let id: Int
    let slug: String
    let name: String
    let background_image: String?
    let rating: Double
    let metacritic: Int?
}
