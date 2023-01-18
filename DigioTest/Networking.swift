//
//  Networking.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

import Foundation

protocol Networking {
    associatedtype APIResponse: Decodable
    typealias Parameters = [String: Any]

    var url: String { get set }
    var method: HTTPMethod? { get set }
    var parameters: Parameters? { get set }
    var session: URLSession { get }

    func request(completion: @escaping (Result<APIResponse, Error>) -> Void)
    func downloadImage(completion: @escaping (Result<Data, Error>) -> Void)
}

extension Networking {
    var session: URLSession { URLSession.shared }

    func request(completion: @escaping (Result<APIResponse, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method?.rawValue
        request.httpBody = Encoder.JSONParameters(parameters)

        session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let convertedResponse = try decoder.decode(APIResponse.self, from: data)
                    completion(.success(convertedResponse))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func downloadImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
