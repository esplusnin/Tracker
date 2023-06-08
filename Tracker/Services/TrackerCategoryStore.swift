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
            print(error.localizedDescription)
        }
        
        return fetchResultController
    }()
    
    private var insertedSet: IndexSet?
    private var deletedSet: IndexSet?
    private var categoryName: String?
    
    func numberOfCategories() -> Int {
        fetchedResultController.fetchedObjects?.count ?? 0
    }
    
    func numberOfRowsInSection(at section: Int) -> Int {
        guard let trackers = fetchedResultController.fetchedObjects?[section].trackers else { return 0 }
        return trackers.count
    }
    
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
        dataProviderServie.inizializeVisibleCategories()
        delegate?.reloadTableView()
        // TODO: переделать
        dataProviderServie.trackersViewController?.reloadCOll()
    }
}
