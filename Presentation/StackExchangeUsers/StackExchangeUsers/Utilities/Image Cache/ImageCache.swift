//
//  ImageFetcher.swift
//  StackExchangeUsers
//
//  Created by TM.DEV on 11/08/2025.
//

import UIKit

protocol ImageFetching {
    func load(_ url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask?
}

final class ImageFetcher {
    static let shared = ImageFetcher()
    
    private let cache = NSCache<NSURL, UIImage>()
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.urlCache = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 200 * 1024 * 1024
        )
        session = URLSession(configuration: config)
    }
}

// MARK: - ImageFetching
extension ImageFetcher {
    /// Returns the data task so callers can cancel it if the cell is reused.
    @discardableResult
    func load(_ url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        let key = url as NSURL

        if let image = cache.object(forKey: key) {
            DispatchQueue.main.async { completion(image) }
            return nil
        }

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        let task = session.dataTask(with: request) { [weak self] data, _, _ in
            var image: UIImage?
            if let data = data, let decoded = UIImage(data: data) {
                image = decoded
                self?.cache.setObject(decoded, forKey: key)
            }
            DispatchQueue.main.async { completion(image) }
        }
        task.resume()
        return task
    }
}
