//
//  CategoryCellDelegate.swift
//  Tracker
//
//  Created by Евгений on 04.07.2023.
//

import Foundation

protocol CategoryCellDelegate: AnyObject {
    func editCategory(_ cell: CategoryCell)
    func removeCategory(_ cell: CategoryCell)
}
