//
//  GameDetailResponse.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 25.05.2024.
//

import Foundation

struct GameDetailResponse: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let tba: Bool?
    let updated: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let metacritic: Int?
    let playtime: Int?
    let achievementsCount: Int?
    let ratingsCount: Int?
    let suggestionsCount: Int?
    let gameSeriesCount: Int?
    let reviewsTextCount: Int?
    let ratings: [Rating]?
    let genres: [Genre]?
    let tags: [Tag]?
    let publishers: [Publisher]?
    let developers: [Developer]?
    let platforms: [GamePlatform]?
    let stores: [Store]?
    let descriptionRaw: String?
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba, updated, genres, tags, publishers, developers, platforms, stores
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case metacritic, playtime
        case achievementsCount = "achievements_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsTextCount = "reviews_text_count"
        case ratings
        case descriptionRaw = "description_raw"
    }
}

struct Rating: Decodable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}

struct Publisher: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct Developer: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct GamePlatform: Decodable {
    let platform: Platform?
    let releasedAt: String?
    let requirements: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirements
    }
}

struct Platform: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct Requirements: Decodable {
    let minimum: String?
    let recommended: String?
}

struct Store: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct Tag: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let language: String?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, language
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

