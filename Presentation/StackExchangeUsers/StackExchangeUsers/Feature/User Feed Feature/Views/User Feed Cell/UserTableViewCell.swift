//
//  UserTableViewCell.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 10/08/2025.
//

import CoreStackExchange
import UIKit

final class UserTableViewCell: UITableViewCell {
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var reputationLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var followButton: UIButton!
    
    private var userID: Int?
    private var imageTask: URLSessionDataTask?
    
    weak var delegate: UserTableViewCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        profileImageView.image = nil
    }
}

// MARK: - StockFeedItemViewable
extension UserTableViewCell: UserTableViewCellUpdateable {
    func update(withModel model: any UserModellabe) {
        userID = model.id
        nameLabel.text = model.displayName
        reputationLabel.text = String(model.reputation)
        updateFollowButton(isFollowing: model.isFollowed)
        loadImage(withModel: model)
    }
    
    func updateFollowButton(isFollowing: Bool) {
        followButton.setTitle(isFollowing ? "Unfollow" : "Follow", for: .normal)
    }
}

// MARK: - Actions
extension UserTableViewCell {
    @IBAction private func didTouchUpInsideFollowButton(_ sender: Any) {
        guard let userID = userID else {
            return
        }
        delegate?.didTapToUpdateFollowStatusFor(userWithId: userID, fromCell: self)
    }
}

// MARK: - Helpers
extension UserTableViewCell {
    private func loadImage(withModel model: any UserModellabe) {
        profileImageView.image = nil
        imageTask?.cancel()
        imageTask = ImageFetcher.shared.load(model.profileImage) { [weak self] image in
            guard let self = self, self.userID == model.id else { return }
            self.profileImageView.image = image
        }
    }
}
