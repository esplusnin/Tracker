//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Евгений on 05.06.2023.
//

import UIKit
import CoreData

final class TrackerCategoryStore: NSObject, TrackerCategoryStoreProtocol {
    
    weak var delegate: CategoryViewControllerProtocol?
    private let dataProviderServie = DataProviderService.instance
    
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
    
    private var insertedSet: IndexSet?
    private var deletedSet: IndexSet?
    
    func numberOfCategories() -> Int {
        fetchResultController.fetchedObjects?.count ?? 0
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        guard let trackers = fetchResultController.fetchedObjects?[section].trackers else { return 0 }
        return trackers.count
    }
    
    func addCategory(name: String) {
        if !checkCategoryIsExist(name: name) {
            let category = TrackerCategoryCoreData(context: context)
            category.name = name
            
            appDelegate.saveContext()
        }
    }
    
    func getCategoryName(at index: Int) -> String {
        guard let category = fetchResultController.fetchedObjects?[index] else { return "" }
        
        return category.name ?? ""
    }
    
    func fetchAllCategories() -> [TrackerCategoryCoreData] {
        fetchResultController.fetchedObjects ?? []
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
    
    private func checkCategoryIsExist(name: String) -> Bool {
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
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedSet = IndexSet()
        deletedSet = IndexSet()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.reloadTableView()
        // TODO: переделать
        dataProviderServie.trackersViewController?.reloadCOll()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                insertedSet?.insert(indexPath.item)
            }
        default:
            break
        }
    }
}
