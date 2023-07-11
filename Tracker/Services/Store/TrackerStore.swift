//
//  TrackerStore.swift
//  Tracker
//
//  Created by Евгений on 05.06.2023.
//

import UIKit
import CoreData

final class TrackerStore: NSObject, TrackerStoreProtocol {
       
    private let colorMarshalling = UIColorMarshallingService()
    private let dataProviderService = DataProviderService.instance
    
    private var trackerCategoryObservation: NSKeyValueObservation?
  
    private lazy var appDelegate = {
        UIApplication.shared.delegate as! AppDelegate
    }()
    
    private lazy var context: NSManagedObjectContext = {
        appDelegate.persistantContainer.viewContext
    }()
        
    private lazy var fetchedResultController: NSFetchedResultsController<TrackerCoreData> = {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "category.name", ascending: true)]
        
        let fetchController = NSFetchedResultsController(fetchRequest: request,
                                                         managedObjectContext: context,
                                                         sectionNameKeyPath: "category.name",
                                                         cacheName: nil)
        fetchController.delegate = self
        
        do {
            try fetchController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        return fetchController
    }()
        
    func fetchTrackers() -> [TrackerCategory] {
        guard let sections = fetchedResultController.sections else { return [] }
        
        var currentArray: [TrackerCategory] = []
        
        for section in sections {
            guard let object = section.objects as? [TrackerCoreData] else { return [] }
            
            var category = TrackerCategory(name: section.name, trackerDictionary: [])
            for tracker in object  {
                let color = colorMarshalling.colorWithHexString(hexString: tracker.color ?? "")
                category.trackerDictionary.append(Tracker(id: tracker.id ?? UUID(),
                                                          name: tracker.name ?? "",
                                                          color: color,
                                                          emoji: tracker.emoji ?? "",
                                                          schedule: tracker.schedule ?? []))
            }
            currentArray.append(category)
        }
        
        return currentArray
    }

    // CRUD Tracker:
    func addTracker(model: Tracker) {
        let category = dataProviderService.fetchSpecificCategory(name: dataProviderService.selectedCategoryString ?? "")
        let tracker = TrackerCoreData(context: context)
        let color = colorMarshalling.hexStringFromColor(color: model.color)
        
        tracker.id = model.id
        tracker.name = model.name
        tracker.color = color
        tracker.emoji = model.emoji
        tracker.schedule = model.schedule
    
        tracker.category = category
            
        appDelegate.saveContext()
    }
    
    func getTracker(categoryName: String, searchedindex: Int) -> Tracker {
        let section = fetchedResultController.sections?.first(where: { section in
            section.name == categoryName
        })
        
        let tracker = section?.objects?[searchedindex] as? TrackerCoreData
        let color = colorMarshalling.colorWithHexString(hexString: tracker?.color ?? "")
        return Tracker(id: tracker?.id ?? UUID(),
                       name: tracker?.name ?? "",
                       color: color,
                       emoji: tracker?.emoji ?? "",
                       schedule: tracker?.schedule ?? [])
    }
    
    func editTracker(newModel: Tracker) {
        guard let tracker = fetchedResultController.fetchedObjects?.first( where: { $0.id == newModel.id }),
              let selectedCategory = dataProviderService.selectedCategoryString else { return }
        
        let category = dataProviderService.fetchSpecificCategory(name: selectedCategory)
        
        tracker.id = newModel.id
        tracker.name = newModel.name
        tracker.emoji = newModel.emoji
        tracker.color = colorMarshalling.hexStringFromColor(color: newModel.color)
        tracker.schedule = newModel.schedule
        tracker.category = category

        appDelegate.saveContext()
    }
    
    func pinTracker(_ trackerID: UUID) {
        guard let tracker = fetchedResultController.fetchedObjects?.first(
            where: { $0.id == trackerID }) else { return }
        
        let pinnedName = L10n.TrackerVC.pinned
        let category = dataProviderService.fetchSpecificCategory(name: pinnedName)
        
        tracker.previousCategory = tracker.category
        tracker.category = category
        
        appDelegate.saveContext()
    }
    
    func unpinTracker(_ trackerID: UUID) {
        guard let tracker = fetchedResultController.fetchedObjects?.first(
            where: { $0.id == trackerID }) else { return }
        
        tracker.category = tracker.previousCategory
        
        appDelegate.saveContext()
    }
    
    func updateController() {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("error", error.localizedDescription)
        }
        
        dataProviderService.inizializeVisibleCategories()
    }
    
    func deleteTracker(id: UUID) {
        guard let object = fetchedResultController.fetchedObjects?.first(where: { trackerCoreData in
            trackerCoreData.id == id
        }) else { return }
        
        context.delete(object)
        appDelegate.saveContext()
    }
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dataProviderService.inizializeVisibleCategories()
        dataProviderService.recordDidUpdate()
    }
}
