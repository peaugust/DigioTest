//
//  HTTPMethod.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

struct HTTPMethod: RawRepresentable {
    static let GET = HTTPMethod(rawValue: "GET")

    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }
}
