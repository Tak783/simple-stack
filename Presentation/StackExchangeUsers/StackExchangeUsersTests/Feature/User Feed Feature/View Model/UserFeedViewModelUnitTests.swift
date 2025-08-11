//
//  UserFeedViewModelUnitTests.swift
//  StackExchangeUsers
//
//  Created by TM.DEV on 10/08/2025.
//

import XCTest
import CoreTesting
import CoreFoundational
import CoreNetworking
import MockNetworking
import CoreStackExchange
@testable import StackExchangeUsers

final class UserFeedViewModelUnitTests: UserFeedViewModelUnitTest {
    override func setUp() {
        super.setUp()
        UserDefaultsSEAPIKeyProvider.setStackExchangeAPIKey(UUID().uuidString)
    }
    
    override func tearDown() {
        super.tearDown()
        TestsUserDefaultsManager.clearUserDefaults()
    }
}

// MARK: - UserFeedViewModelUnitTestSpec
extension UserFeedViewModelUnitTests {
    func test_init_setsInitialVariablesCorrectly() {
        let title = "Users"
        let client = HTTPClientSpy()
        let remoteUserFeedService = RemoteUserFeedService(client: client)
        let (sut, _) = make_sut(userFeedService: remoteUserFeedService, title: title)

        XCTAssertEqual(sut.title, title)
    }

    func test_loadFeed_setsLoadStateToTrue() {
        let client = HTTPClientSpy()
        let remoteUserFeedService = RemoteUserFeedService(client: client)
        let (sut, spy) = make_sut(userFeedService: remoteUserFeedService)

        sut.loadFeed()

        XCTAssertEqual(spy.isLoading, true)
    }

    func test_loadFeed_triggersAPICall_whichSuccessOrFailure_setsLoadStateToFalse() {
        let client = HTTPClientSpy()
        let remoteUserFeedService = RemoteUserFeedService(client: client)
        let (sut, spy) = make_sut(userFeedService: remoteUserFeedService)

        sut.loadFeed()
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 400, data: MockData.any_badJSONData())
        XCTAssertEqual(spy.isLoading, false)

        sut.loadFeed()
        XCTAssertEqual(spy.isLoading, true)
        client.complete(withStatusCode: 200, data: Data()) // invalid data still flips loading off
        XCTAssertEqual(spy.isLoading, false)
    }

    func test_loadFeed_triggersAPICall_whichOnError_returnsError() {
        let client = HTTPClientSpy()
        let remoteUserFeedService = RemoteUserFeedService(client: client)
        let (sut, spy) = make_sut(userFeedService: remoteUserFeedService)
        let expectedError = NSError(domain: "Any Error", code: 404)

        sut.loadFeed()
        client.complete(with: expectedError)

        XCTAssertNotNil(spy.error)
    }

    func test_loadFeed_triggersAPICall_whichOnSuccess_returnsUsers() {
        let client = HTTPClientSpy()
        let remoteUserFeedService = RemoteUserFeedService(client: client)
        let (sut, spy) = make_sut(userFeedService: remoteUserFeedService)

        // Update this filename to your actual fixture name, e.g. `.usersFeed`
        let data = MockData.any_data(for: MockData.FileName.userFeed.rawValue, fromBundle: .main)
        let expectedFeed = try! JSONDecoder().decode(RemoteUserFeedResponse.self, from: data)

        sut.loadFeed()
        client.complete(withStatusCode: 200, data: data)

        XCTAssertEqual(spy.users, expectedFeed.items.map { UserModel(from: $0) })
        XCTAssertEqual(spy.error, .none)
    }
}

// MARK: - Make SUT
extension UserFeedViewModelUnitTests {
    private func make_sut(
        userFeedService: RemoteUserFeedService,
        title: String = "Feed"
    ) -> (sut: UserFeedViewModel, spy: UserFeedSpy) {
        let userFollowingService = UserDefaultsFollowUserService()
        let sut = UserFeedViewModel(
            userFeedService: userFeedService,
            userFollowingService: userFollowingService,
            title: title
        )
        let spy = UserFeedSpy(viewModel: sut)
        return (sut, spy)
    }
}

// MARK: - UserFeedSpy
extension UserFeedViewModelUnitTests {
    private class UserFeedSpy: NSObject {
        var isLoading: Bool = false
        var error: String?
        var users: [UserModel]?

        var viewModel: UserFeedViewModel

        init(viewModel: UserFeedViewModel) {
            self.viewModel = viewModel
            super.init()
            bind()
        }

        private func bind() {
            viewModel.onLoadingStateChange = { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            viewModel.onFeedLoadError = { [weak self] error in
                self?.error = error
            }
            viewModel.onFeedLoadSuccess = { [weak self] _ in
                self?.users = self?.viewModel.userModels
            }
        }
    }
}
