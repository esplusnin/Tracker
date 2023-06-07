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
    
    private var insertedIndex: IndexSet?
    private var deletedIndex: IndexSet?
    
    private lazy var appDelegate = {
        (UIApplication.shared.delegate as! AppDelegate)
    }()
    
    private lazy var context: NSManagedObjectContext = {
        appDelegate.persistantContainer.viewContext
    }()
        
    private lazy var trackerFetchResultController: NSFetchedResultsController<TrackerCoreData> = {
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
        guard let sections = trackerFetchResultController.sections else { return [] }
        
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
        let section = trackerFetchResultController.sections?.first(where: { section in
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
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedIndex = IndexSet()
        deletedIndex = IndexSet()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let insertedIndex = insertedIndex, let deletedIndex = deletedIndex else { return }
        dataProvider.inizializeVisibleCategories()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dataProvider.updateTrackersCollection(CollectionStoreUpdates(insertedIndex: insertedIndex,
                                                                         deletedIndex: deletedIndex))

        }
        
        self.insertedIndex = nil
        self.deletedIndex = nil
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                insertedIndex?.insert(indexPath.item)
            } else {
                // TODO: Удалить перед отправкой на ревью
                fatalError("ошибка в методе controller didChange")
            }
        case .delete:
            if let indexPath = indexPath {
                deletedIndex?.insert(indexPath.item)
            } else {
                // TODO: Удалить перед отправкой на ревью
                fatalError("ошибка в методе controller didChange")
            }
        default:
            break
        }
    }
}
