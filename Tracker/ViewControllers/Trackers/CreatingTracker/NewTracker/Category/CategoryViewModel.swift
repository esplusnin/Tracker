//
//  CategoryViewModel.swift
//  Tracker
//
//  Created by Евгений on 19.06.2023.
//

import Foundation

final class CategoryViewModel: CategoryViewModelProtocol {
    
    private let dataProviderService = DataProviderService.instance
    
    @Observable
    private(set) var visibleCategories: [String] = []
    var numberOfCategories: Int? {
        visibleCategories.count
    }
    
    init() {
        dataProviderService.bindCategoryViewModel(controller: self)
        updateVisibleCategories()
    }
    
    func updateVisibleCategories() {
        var categories = dataProviderService.updateCategoryViewModel()

        if let index = visibleCategories.firstIndex(where: { $0 == LocalizableConstants.TrackerVC.pinned }) {
            categories.remove(at: index)
        }
        
        visibleCategories = categories
    }
    
    func setSelectedCategory(name: String) {
        dataProviderService.selectedCategoryString = name
    }
    
    func getSelectedCategory() -> String {
        dataProviderService.selectedCategoryString ?? ""
    }
    
    func removeCategory(_ name: String) {
        dataProviderService.removeCategory(name)
    }
}
