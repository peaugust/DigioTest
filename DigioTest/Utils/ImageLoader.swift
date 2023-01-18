//
//  ImageLoader.swift
//  DigioTest
//
//  Created by Pedro Freddi on 17/01/23.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }

    func load(_ imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: imageUrl as NSString) {
            completion(image)
            return
        }
        RequestImage(url: imageUrl).downloadImage { result in
            switch result {
            case .success(let data):
                completion(UIImage(data: data))
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
