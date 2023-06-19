//
//  FirstEntryRevisionService.swift
//  Tracker
//
//  Created by Евгений on 19.06.2023.
//

import Foundation

final class FirstEntryRevisionService {
    
    private let userDefaults = UserDefaults.standard
    
    var isFirstEntry: Bool {
        get {
            if userDefaults.object(forKey: "isFirstEntryCheck") == nil {
                return true
            } else {
                return userDefaults.bool(forKey: "isFirstEntryCheck")
            }
        }
        set {
            userDefaults.set(newValue, forKey: "isFirstEntryCheck")
        }
    }
}
