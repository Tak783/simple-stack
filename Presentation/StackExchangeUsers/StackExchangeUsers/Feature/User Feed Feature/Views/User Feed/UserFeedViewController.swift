//
//  UserFeedViewController.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 10/08/2025.
//

import UIKit
import CoreFoundational
import CorePresentation

final class UserFeedViewController: StoryboardedViewController {
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var errorViewTitleLabel: UILabel!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.accessibilityIdentifier = "user-feed-table"
        }
    }
    
    var feedViewModel: UserFeedViewModellable? {
        didSet {
            bind()
        }
    }
 
    // MARK: - View Controller Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refreshFeed()
    }
}

// MARK: - Setup View
extension UserFeedViewController {
    private func setupView() {
        setupRefreshControl()
        setupTableView()
        makeAccessible()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func makeAccessible() {
        tableView.makeViewAccessible(
            isAccessibilityElement: true,
            accessibilityLabel: "Users Feed",
            accessibilityHint: "Shows a feed of users"
        )
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.accessibilityIdentifier = "feed-refresh-control"
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

// MARK: - Bind View
extension UserFeedViewController {
    private func bind() {
        title = feedViewModel?.title
        bindLoadingState()
        bindLoadingErrorState()
        bindLoadingEmptyState()
    }
    
    private func bindLoadingState() {
        feedViewModel?.onLoadingStateChange = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.setLoadingState(isLoading)
            }
        }
    }
    
    private func bindLoadingErrorState() {
        feedViewModel?.onFeedLoadError = { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showErrorView(withErrorMessage: errorMessage)
            }
        }
    }
    
    private func bindLoadingEmptyState() {
        feedViewModel?.onFeedLoadEmptyState = { [weak self] isEmpty in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showEmptyFeedState(isEmpty)
            }
        }
    }
}

// MARK: - Bind View
extension UserFeedViewController {
    private func showErrorView(
        withErrorMessage errorMessage: String?,
        backgroundColor: UIColor = .red
    ) {
        var errrorViewIsHidden = true
        if errorMessage != .none {
            errrorViewIsHidden = false
            errorViewTitleLabel.text = errorMessage
        }
        errorView.isHidden = errrorViewIsHidden
        errorView.backgroundColor = backgroundColor
    }
    
    private func showEmptyFeedState(_ isEmpty: Bool) {
        showErrorView(
            withErrorMessage: isEmpty ? "User feed returned was empty\n Pull to refresh feed" : .none,
            backgroundColor: .systemBlue
        )
    }
}

// MARK: - Setup Table View
extension UserFeedViewController {
    private func setupTableView() {
        registerCellsForTable()
        setupRefreshControl()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCellsForTable() {
        let bundle = Bundle(for: UserTableViewCell.self)
        let nib = UINib(nibName: UserTableViewCell.className, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: UserTableViewCell.className)
    }
}

// MARK: - Reload Table
extension UserFeedViewController {
    private func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    @objc private func refreshFeed() {
        feedViewModel?.loadFeed()
    }
    
    private func setLoadingState(_ willShowLoadingState: Bool) {
        if willShowLoadingState {
            errorView.isHidden = true
            if tableView.refreshControl?.isRefreshing == false {
                tableView.refreshControl?.beginRefreshing()
            }
        } else {
            tableView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource
extension UserFeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel?.userModels.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userModel = feedViewModel?.userModels[indexPath.row]  else {
            assertionFailure("ViewModel should adhere to `UsersFeedItemTableViewControllable`")
            return .init()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.className) as? UserTableViewCell else {
            assertionFailure("Could not dequeue `StocksFeedTableViewCell` from TableView")
            return .init()
        }
        cell.delegate = self
        cell.update(withModel: userModel)
        return .init()
    }
}

// MARK: - UITableViewDelegate
extension UserFeedViewController: UITableViewDelegate {}

// MARK: - UITableViewDelegate
extension UserFeedViewController: UserTableViewCellDelegate {
    func didTapToUpdateFollowStatusFor(userWithId userID: Int) {
        feedViewModel?.didRequestToUpdateFollowStatusFor(userWithId: userID)
    }
}
