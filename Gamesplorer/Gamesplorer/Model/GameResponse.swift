//
//  GameResponse.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
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
    let released: String?
    let background_image: String?
    let metacritic: Int?
    let parent_platforms: [ParentPlatform]
    let tags: [Tag]
    let genres: [Genre]
}

struct ParentPlatform: Decodable {
    let platform: Platform
}

struct Platform: Decodable {
    let id: Int
    let name: String
}

struct Tag: Decodable {
    let id: Int
    let name: String
    let slug: String
    let games_count: Int
    let image_background: String
}

