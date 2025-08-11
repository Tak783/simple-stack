//
//  UserTableViewCellDelegate.swift
//  StackExchangeUsers
//
//  Created by TM.DEV on 11/08/2025.
//

protocol UserTableViewCellDelegate: AnyObject {
    func didTapToUpdateFollowStatusFor(userWithId userID: Int, fromCell cell: UserTableViewCellUpdateable)
}
