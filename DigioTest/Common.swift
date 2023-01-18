//
//  Common.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

import Foundation

struct RequestImage: Networking {
    typealias APIResponse = Data

    var url: String
    
    var method: HTTPMethod?
    
    var parameters: Parameters?
    
    init(url: String) {
        self.url = url
    }
}
