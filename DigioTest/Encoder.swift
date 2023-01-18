//
//  Encoder.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

import Foundation

struct Encoder {
    static func JSONParameters(_ parameters: Networking.Parameters?) -> Data? {
        guard let parameters = parameters else { return nil }
        do {
            return try JSONSerialization.data(withJSONObject: parameters)
        } catch _ {
            return nil
        }
    }
}
