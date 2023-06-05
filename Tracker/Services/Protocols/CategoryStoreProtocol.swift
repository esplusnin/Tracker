//
//  Protocols.swift
//  Tracker
//
//  Created by Евгений on 04.06.2023.
//

import Foundation

protocol CoreDataProviderProtocol: AnyObject {
    var numberOfSection: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func object(at indexPath: IndexPath) -> Tracker
    func getCategoryName(at row: Int) -> String
    func addTracker(model: Tracker)
    func updateTracker()
    func deleteTracker()
}
