//
//  GameResponse.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import Foundation

struct GameResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Game]?
}

struct Game: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let background_image: String?
    let metacritic: Int?
    let parent_platforms: [ParentPlatform]
    let tags: [Tag]?
    let genres: [Genre]?
    let short_screenshots: [Screenshots]
}

struct ParentPlatform: Decodable {
    let platform: Platform?
}

struct Screenshots: Decodable {
    let id: Int?
    let image: String?
}


