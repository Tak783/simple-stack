//
//  UserFeedViewController+DSLs.swift
//  StackExchangeUsers
//
//  Created by TM.DEV on 11/08/2025.
//


import XCTest
import CoreTesting
import CoreStackExchange
@testable import StackExchangeUsers

// MARK: - Domain Specific Language Var's
extension UserFeedViewController {
    var table: UITableView? {
        view.findChildView(byAccessibilityIdentifier: "users-feed-table") as? UITableView
    }
    
    var loadingIndicator: UIRefreshControl? {
        table?.refreshControl
    }

    var isShowingLoadingState: Bool {
        guard let loadingView = loadingIndicator else {
            assertionFailure("Loading Indicator should be present")
            return false
        }
        return loadingView.isRefreshing
    }

    var errorView: UIView? {
        view.findChildView(byAccessibilityIdentifier: "error-view")
    }

    var refreshControl: UIRefreshControl? {
        view.findChildView(byAccessibilityIdentifier: "feed-refresh-control") as? UIRefreshControl
    }

    var isShowingErrorState: Bool {
        if errorView == nil {
            assertionFailure("Error View should not be nil")
        }
        if errorView?.isHidden == false, isShowingLoadingState == false  {
            return true
        }
        return false
    }
}

// MARK: - Domain Specific Language Functions
extension UserFeedViewController {
    func simulatePullToRefresh() {
        refreshControl?.beginRefreshing()
    }
}
