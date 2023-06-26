//
//  CategoryViewModel.swift
//  Tracker
//
//  Created by Евгений on 19.06.2023.
//

import Foundation

final class CategoryViewModel: CategoryViewModelProtocol {
    
    private let dataProviderService = DataProviderService.instance
    
    @CategoryObservable
    private(set) var visibleCategories: [String] = []
    var numberOfCategories: Int? {
        visibleCategories.count
    }
    
    init() {
        dataProviderService.bindCategoryViewModel(controller: self)
        updateVisibleCategories()
    }
    
    func updateVisibleCategories() {
        visibleCategories = dataProviderService.updateCategoryViewModel()
    }
    
    func setSelectedCategory(name: String) {
        dataProviderService.selectedCategoryString = name
    }
    
    func getSelectedCategory() -> String {
        dataProviderService.selectedCategoryString ?? ""
    }
}
