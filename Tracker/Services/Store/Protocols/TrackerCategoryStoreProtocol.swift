//
//  TrackerCategoryStoreProtocol.swift
//  Tracker
//
//  Created by Евгений on 06.06.2023.
//

import Foundation

protocol TrackerCategoryStoreProtocol: AnyObject {
    var delegate: TrackersCategoryDelegate? { get set }
    func numberOfCategories() -> Int
    func numberOfRowsInSection(at section: Int) -> Int
    func addCategory(name: String)
    func getCategoryName(at index: Int) -> String
    func fetchSpecificCategory(name: String) -> TrackerCategoryCoreData?
}
