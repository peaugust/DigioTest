//
//  Spotlight.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import Foundation

protocol Banner {
    var name: String { get }
    var imageUrl: String { get }
    var description: String { get }
    var imageData: Data? { get set }
}

struct Spotlight: Banner, Codable {
    var name: String
    var imageUrl: String
    var description: String
    var imageData: Data?

    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "bannerURL"
        case description
        case imageData
    }
}

struct Product: Banner, Codable {
    var name: String
    var imageUrl: String
    var description: String
    var imageData: Data?

    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "imageURL"
        case description
        case imageData
    }
}

struct Cash: Banner, Codable {
    var name: String
    var imageUrl: String
    var description: String
    var imageData: Data?

    enum CodingKeys: String, CodingKey {
        case name = "title"
        case imageUrl = "bannerURL"
        case description
        case imageData
    }
}
