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
    
    private lazy var fetchResultController: NSFetchedResultsController<TrackerCategoryCoreData> = {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchResultController = NSFetchedResultsController(fetchRequest: request,
                                                               managedObjectContext: context,
                                                               sectionNameKeyPath: nil,
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
        print("numberOfCategories - \(fetchResultController.sections?.count ?? 0)")
        return fetchResultController.fetchedObjects?.count ?? 0
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
        let section = fetchResultController.object(at: indexPath)
        print(section)
        
        return section.name ?? ""
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
}

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    override func didChangeValue(forKey key: String) {
        print("изменение")
    }
}
