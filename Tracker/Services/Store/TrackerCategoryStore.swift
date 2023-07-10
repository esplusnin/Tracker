//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Евгений on 05.06.2023.
//

import UIKit
import CoreData

final class TrackerCategoryStore: NSObject, TrackerCategoryStoreProtocol {
        
    private let dataProviderService = DataProviderService.instance
    
    private lazy var appDelegate = {
        UIApplication.shared.delegate as! AppDelegate
    }()
    
    private lazy var context: NSManagedObjectContext = {
        appDelegate.persistantContainer.viewContext
    }()
    
    private lazy var fetchedResultController: NSFetchedResultsController<TrackerCategoryCoreData> = {
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
            assertionFailure("Load TrackerCategory fetchedResultController")
        }
        
        return fetchResultController
    }()
    
    private var insertedSet: IndexSet?
    private var deletedSet: IndexSet?
    private var categoryName: String?
    
    func getNumberOfCategories() -> Int {
        fetchedResultController.fetchedObjects?.count ?? 0
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        guard let trackers = fetchedResultController.fetchedObjects?[section].trackers else { return 0 }
        return trackers.count
    }
    
    // CRUD TrackerCategory:
    func addCategory(name: String) {
        if !checkCategoryIsExist(name: name) {
            let category = TrackerCategoryCoreData(context: context)
            category.name = name
            categoryName = name
            
            appDelegate.saveContext()
        }
    }
    
    func getCategoryName(at index: Int) -> String {
        guard let category = fetchedResultController.fetchedObjects?[index] else { return "" }
        
        return category.name ?? ""
    }
    
    func fetchCategoryNames() -> [String] {
        guard let categoryName = fetchedResultController.fetchedObjects else { return [] }
        
        return categoryName.map { $0.name ?? "" }
    }
    
    func fetchSpecificCategory(name: String) -> TrackerCategoryCoreData? {
        var wantedCategory: TrackerCategoryCoreData?
        
        if let categories = fetchedResultController.fetchedObjects {
            categories.forEach { category in
                if category.name == name {
                    wantedCategory = category
                }
            }
        }
        
        return wantedCategory
    }
    
    func editCategory(oldName: String, newName: String) {
        guard let object = fetchedResultController.fetchedObjects?.first(where: { $0.name == oldName }) else { return }
        object.name = newName
        
        appDelegate.saveContext()
    }
    
    func removeCategory(_ name: String) {
        guard let object = fetchedResultController.fetchedObjects?.first(where: { $0.name == name }) else { return }
        context.delete(object)
        appDelegate.saveContext()
    }
    
    private func checkCategoryIsExist(name: String) -> Bool {
        guard let categories = fetchedResultController.fetchedObjects else { return false }

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
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dataProviderService.getCategoryNames()
        dataProviderService.updateTrackerStoreController()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                deletedSet?.insert(indexPath.item)
            }
        case .insert:
            if let indexPath = newIndexPath {
                insertedSet?.insert(indexPath.item)
            }
        case .update:
            if let indexPath = indexPath {
                insertedSet?.insert(indexPath.item)
            }
        default:
            break
        }
    }
}
