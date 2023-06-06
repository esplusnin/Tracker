//
//  TrackerStore.swift
//  Tracker
//
//  Created by Евгений on 05.06.2023.
//

import UIKit
import CoreData

final class TrackerStore: NSObject {
    
    static let instance = TrackerStore()
    
    private let colorMarshalling = UIColorMarshallingService()
    private let trackerCategoryStore = TrackerCategoryStore.instance
    private let dataProvider = DataProviderService.instance
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    private lazy var context: NSManagedObjectContext = {
        appDelegate.persistantContainer.viewContext
    }()
    
    private lazy var trackerFetchResultController: NSFetchedResultsController<TrackerCoreData> = {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let fetchController = NSFetchedResultsController(fetchRequest: request,
                                                         managedObjectContext: context,
                                                         sectionNameKeyPath: "name",
                                                         cacheName: nil)
        fetchController.delegate = self
        
        do {
            try fetchController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        return fetchController
    }()
    
    func addTracker(model: Tracker) {
        let tracker = TrackerCoreData(context: context)
        let color = colorMarshalling.hexStringFromColor(color: model.color)
        
        tracker.id = model.id
        tracker.name = model.name
        tracker.color = color
        tracker.emoji = model.emoji
        tracker.schedule = model.schedule
        
        let category = trackerCategoryStore.fetchSpecificCategory(name: dataProvider.selectedCategoryString ?? "")
        
        if category != nil {
            category?.addToTrackers(tracker)
            print(tracker)
            
            appDelegate.saveContext()
        }
    }
    
    func getTrackerCore(at indexPath: IndexPath) {
        
    }
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    
}
