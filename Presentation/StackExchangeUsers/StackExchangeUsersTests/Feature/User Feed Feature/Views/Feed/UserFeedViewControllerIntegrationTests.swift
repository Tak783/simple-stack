//
//  UserFeedViewControllerIntegrationTests.swift
//  StackExchangeUsers
//
//  Created by TM.DEV on 11/08/2025.
//

import XCTest
import CoreFoundational
import CoreNetworking
import MockNetworking
import CoreStackExchange

@testable import StackExchangeUsers

final class UserFeedViewControllerIntegrationTests: XCTestCase {
    func test_initialState() {
        let sut = make_sut()

        test_title_isCorrect(for: sut)
        XCTAssertEqual(sut.isShowingErrorState, false, "Should Not Be Showing Error State")
    }
}

// MARK: - Make SUT
extension UserFeedViewControllerIntegrationTests {
    private func make_sut() -> UserFeedViewController {
        let bundle = Bundle(for: UserFeedViewController.self)
        let storyboard = UIStoryboard(name: "UserFeed", bundle: bundle)
        let navigationController = UINavigationController()
        let sut = storyboard.instantiateViewController(withIdentifier: UserFeedViewController.className) as! UserFeedViewController
        navigationController.pushViewController(sut, animated: false)
        sut.loadViewIfNeeded()
        return sut
    }
}

// MARK: - Test Helpers
extension UserFeedViewControllerIntegrationTests {
    private func test_title_isCorrect(for sut: UserFeedViewController,
                                      file: StaticString = #file, line: UInt  = #line) {
        XCTAssertEqual(sut.navigationController?.navigationBar.prefersLargeTitles, true, file: file, line: line)
        XCTAssertEqual(sut.navigationItem.title, "Users", file: file, line: line)
    }
}
