//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Евгений on 07.06.2023.
//

import UIKit
import CoreData

final class TrackerRecordStore: NSObject, TrackerRecordStoreProtocol {
    
    private let dataProviderService = DataProviderService.instance
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    private lazy var context: NSManagedObjectContext = {
        (appDelegate.persistantContainer.viewContext)
    }()
    
    private lazy var fetchedResultController: NSFetchedResultsController<TrackerRecordCoreData> = {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let fetchedController = NSFetchedResultsController(fetchRequest: request,
                                                           managedObjectContext: context,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
        
        fetchedController.delegate = self
        
        do {
            try fetchedController.performFetch()
        } catch {
            print(error.localizedDescription)
        }

        return fetchedController
    }()
    
    func addRecord(tracker: TrackerRecord) {
        if !isTrackerRecordExistToday(tracker: tracker) {
            let record = TrackerRecordCoreData(context: context)
            let date = DateService().convertDateWithoutTimes(date: tracker.date)
            
            record.id = tracker.id
            record.date = date
            
            appDelegate.saveContext()
        }
    }
    
    func deleteRecord(tracker: TrackerRecord) {
        guard let objects = fetchedResultController.fetchedObjects else { return }
        var recordToDelete: TrackerRecordCoreData?
        
        if isTrackerRecordExistToday(tracker: tracker) {
            objects.forEach { record in
                if record.id == tracker.id && record.date == tracker.date {
                    recordToDelete = record
                }
            }
            
            guard let object = try? context.existingObject(
                with: recordToDelete?.objectID ?? NSManagedObjectID()) else { return }
            
            context.delete(object)
            appDelegate.saveContext()
        }
    }
    
    func getTrackerRecords() -> [TrackerRecord] {
        guard let coreRecords = fetchedResultController.fetchedObjects else { return [] }
        var newRecordsArray: [TrackerRecord] = []
        
        for record in coreRecords {
            newRecordsArray.append(TrackerRecord(id: record.id ?? UUID(),
                                                 date: record.date ?? Date()))
        }
        
        return newRecordsArray
    }
    
    private func isTrackerRecordExistToday(tracker: TrackerRecord) -> Bool {
        guard let objects = fetchedResultController.fetchedObjects else { return false }
        var answer = false
        
        objects.forEach { object in
            if object.id == tracker.id && object.date == tracker.date {
                answer = true
            }
        }
        
        return answer
    }
}


extension TrackerRecordStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dataProviderService.setAllTrackerRecords()
    }
}
