//
//  RemoteUserFeedService.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import Foundation
import CoreNetworking
import CoreStackExchange

struct RemoteUserFeedService: UserFeedServiceable {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func load(completion: @escaping (UserFeedLoadResult) -> Void) {
        guard let apiKey = UserDefaultsSEAPIKeyProvider.stackExchangeAPIKey() else {
            completion(.failure(NetworkingError.missingAPIKey))
            return
        }
        let request = URLPool.usersRequest(apiKey: apiKey)
        client.performRequest(request) { result in
            switch result {
            case let .success((data, response)):
                self.handleLoadUsersSuccessResponse(data: data, response: response, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private helpers
private extension RemoteUserFeedService {
    func handleLoadUsersSuccessResponse(
        data: Data,
        response: HTTPURLResponse,
        completion: @escaping (UserFeedServiceable.UserFeedLoadResult) -> Void
    ) {
        do {
            guard response.statusCode == 200 else {
                completion(.failure(NetworkingError.invalidResponse))
                return
            }
            let feed = try JSONDecoder().decode(RemoteUserFeedResponse.self, from: data)
            let users = feed.items.map { UserModel(from: $0) }
            completion(.success(users))
        } catch {
            completion(.failure(NetworkingError.invalidData))
        }
    }
}
