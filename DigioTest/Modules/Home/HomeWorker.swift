//
//  HomeWorker.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

import Foundation

protocol HomeWorkerLogic {
    func requestContent(completion: @escaping (Result<HomeContent, Error>) -> Void)
}

class HomeWorker: HomeWorkerLogic {
    func requestContent(completion: @escaping (Result<HomeContent, Error>) -> Void) {
        RequestContent().request { response in
            switch response {
            case .success(let content):
                completion(.success(content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
