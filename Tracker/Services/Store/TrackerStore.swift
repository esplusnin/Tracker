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
    private let dataProvider = DataProviderService.instance
  
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
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
        let category = dataProvider.fetchSpecificCategory(name: dataProvider.selectedCategoryString ?? "")
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
    
    func editTracker(id: UUID) {
        // Заготовка
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
        dataProvider.inizializeVisibleCategories()
    }
}
