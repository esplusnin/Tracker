//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Евгений on 05.06.2023.
//

import UIKit
import CoreData

final class TrackerCategoryStore: NSObject {
    
    static let instance = TrackerCategoryStore()
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    private lazy var context: NSManagedObjectContext = {
        appDelegate.persistantContainer.viewContext
    }()
    
     lazy var fetchResultController: NSFetchedResultsController<TrackerCategoryCoreData> = {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchResultController = NSFetchedResultsController(fetchRequest: request,
                                                               managedObjectContext: context,
                                                               sectionNameKeyPath: "name",
                                                               cacheName: nil)
        
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        return fetchResultController
    }()
    
    func numberOfCategories() -> Int {
        fetchResultController.sections?.count ?? 0
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        guard let trackers = fetchResultController.object(
            at: IndexPath(row: 0, section: section)).trackers else { return 0 }
        
        return trackers.count
    }
    
    func addCategory(name: String) {
        if !checkCategoryIsExist(name: name) {
            let category = TrackerCategoryCoreData(context: context)
            category.name = name

            appDelegate.saveContext()
        }
    }
    
    func deleteCategory() {
        
    }
    
    func getCategoryName(at indexPath: IndexPath) -> String {
        let index = IndexPath(row: 0, section: indexPath.row)
        let category = fetchResultController.object(at: index)
        
        return category.name ?? ""
    }
    
    func checkCategoryIsExist(name: String) -> Bool {
        guard let categories = fetchResultController.fetchedObjects else { return false }
        var categoryName = ""
        
        for category in categories {
            if category.name == name {
                categoryName = name
            }
        }
        
        return categoryName == "" ? false : true
    }
    
    func fetchSpecificCategory(name: String) -> TrackerCategoryCoreData? {
        var wantedCategory: TrackerCategoryCoreData?
        
        if let categories = fetchResultController.fetchedObjects {
            categories.forEach { category in
                if category.name == name {
                    wantedCategory = category
                }
            }
        }
        
        return wantedCategory
    }
}

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    override func didChangeValue(forKey key: String) {
        print("изменение")
    }
}
