//
//  Untitled.swift
//  StackUsers
//
//  Created by Tak Mazarura on 07/08/2025.
//

import XCTest
import CoreNetworking
import MockNetworking
import CoreStackExchange
@testable import StackExchangeUsers

final class RemoteUserFeedServiceTests: RemoteUserFeedServiceTest {
    override func setUp() {
        UserDefaultsSEAPIKeyProvider.setStackExchangeAPIKey(UUID().uuidString)
    }
    
    override func tearDown() {
        UserDefaultsSEAPIKeyProvider.deleteStackExchangeAPIKey()
    }
}

// MARK: - Load Feed Failure Tests
extension RemoteUserFeedServiceTests {
    func test_load_onSuccessWithNon200Code_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: NetworkingError?
        let exp = expectation(description: "Wait for load completion")

        sut.load { result in
            switch result {
            case .success:
                XCTFail("Expected load to fail because non-200 should be an error")
            case .failure(let error as NetworkingError):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected NetworkingError.invalidResponse")
            }
        }

        client.complete(withStatusCode: 100, data: .init())
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidResponse)
    }

    func test_load_onSuccessWithInvalidData_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: NetworkingError?
        let exp = expectation(description: "Wait for load completion")

        sut.load { result in
            switch result {
            case .success:
                XCTFail("Expected load to fail due to invalid data")
            case .failure(let error as NetworkingError):
                returnedError = error
                exp.fulfill()
            case .failure:
                XCTFail("Expected NetworkingError.invalidData")
            }
        }

        client.complete(withStatusCode: 200, data: MockData.any_badJSONData())
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedError, .invalidData)
    }

    func test_load_onFailure_returnsError() {
        let (sut, client) = make_sut()

        var returnedError: Error?
        let exp = expectation(description: "Wait for load completion")

        sut.load { result in
            switch result {
            case .success:
                XCTFail("Expected load to fail due to client error")
            case .failure(let error):
                returnedError = error
                exp.fulfill()
            }
        }

        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)

        wait(for: [exp], timeout: 1.0)

        XCTAssertNotNil(returnedError)
    }
}

// MARK: - Load Feed Success Tests
extension RemoteUserFeedServiceTests {
    func test_load_onSuccess_returnsUsers() {
        let (sut, client) = make_sut()

        var returnedUsers: [UserModel] = []
        let exp = expectation(description: "Wait for load completion")

        sut.load { result in
            switch result {
            case .success(let users):
                returnedUsers = users
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        // Adjust filename to your fixture name
        let data = MockData.any_data(for: MockData.FileName.userFeed.rawValue)

        // Decode with the same container used by production code
        let expectedResponse = try! JSONDecoder().decode(RemoteUserFeedResponse.self, from: data)

        client.complete(withStatusCode: 200, data: data)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(returnedUsers, expectedResponse.items.map { UserModel(from: $0) })
    }
}

// MARK: - Make Sut
extension RemoteUserFeedServiceTests {
    private func make_sut() -> (sut: RemoteUserFeedService, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteUserFeedService(client: client)
        // Add `trackForMemoryLeaks` function
        return (sut, client)
    }
}
