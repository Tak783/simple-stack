//
//  UserTableViewCellDelegate.swift
//  StackExchangeUsers
//
//  Created by Tak Mazarura on 11/08/2025.
//

protocol UserTableViewCellDelegate: AnyObject {
    func didTapToUpdateFollowStatusFor(userWithId userID: Int)
}
