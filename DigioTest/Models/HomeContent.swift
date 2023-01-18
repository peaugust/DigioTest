//
//  HomeContent.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import Foundation

struct HomeContent: Codable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
    
    func toArray() -> [[Banner]] {
        return [spotlight, products, [cash]]
    }
}
