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
}

// MARK: - StockFeedItemViewable
extension UserTableViewCell: UserTableViewCellUpdateable {
    func update(withModel model: any UserModellabe) {
        nameLabel.text = model.displayName
        reputationLabel.text = String(model.reputation)
    }
}
