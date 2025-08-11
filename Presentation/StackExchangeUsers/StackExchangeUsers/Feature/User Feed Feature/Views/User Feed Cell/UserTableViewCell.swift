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
    
    weak var delegate: UserTableViewCellDelegate?
}

// MARK: - StockFeedItemViewable
extension UserTableViewCell: UserTableViewCellUpdateable {
    func update(withModel model: any UserModellabe) {
        userID = model.id
        nameLabel.text = model.displayName
        reputationLabel.text = String(model.reputation)
        updateFllowButton(isFollowing: model.isFollowed)
    }
    
    func updateFllowButton(isFollowing: Bool) {
        followButton.setTitle(isFollowing ? "Unfollow" : "Follow", for: .normal)
    }
}

// MARK: - Actions
extension UserTableViewCell {
    @IBAction func didTouchUpInsideFollowButton(_ sender: Any) {
        guard let userID = userID else {
            return
        }
        delegate?.didTapToUpdateFollowStatusFor(userWithId: userID)
    }
}
