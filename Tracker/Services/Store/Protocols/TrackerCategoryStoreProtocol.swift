//
//  TrackerCategoryStoreProtocol.swift
//  Tracker
//
//  Created by Евгений on 06.06.2023.
//

import Foundation

protocol TrackerCategoryStoreProtocol: AnyObject {
    func addCategory(name: String)
    func getCategoryName(at index: Int) -> String
    func fetchCategoryNames() -> [String]
    func fetchSpecificCategory(name: String) -> TrackerCategoryCoreData?
    func editCategory(oldName: String, newName: String)
    func removeCategory(_ name: String)
}
