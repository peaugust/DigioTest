//
//  HomeModels.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import Foundation

enum Home {
    enum Content {        
        struct Request {}

        struct Response {
            let content: HomeContent
        }

        struct ViewModelSuccess {
            let banners: [[Banner]]
        }

        struct ViewModelFailure {
            let errorMessage: String
        }
    }
}
