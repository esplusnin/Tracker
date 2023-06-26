//
//  CategoryViewModelProtocol.swift
//  Tracker
//
//  Created by Евгений on 19.06.2023.
//

import Foundation

protocol CategoryViewModelProtocol: AnyObject {
    func updateVisibleCategories()
    func setSelectedCategory(name: String)
    func getSelectedCategory() -> String
}
