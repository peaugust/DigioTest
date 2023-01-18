//
//  Home.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

import Foundation


struct RequestContent: Networking {
    typealias APIResponse = HomeContent

    var url: String = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"

    var method: HTTPMethod? = .GET

    var parameters: Parameters?
}

