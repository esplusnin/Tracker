//
//  AppDelegate.swift
//  Tracker
//
//  Created by Евгений on 18.05.2023.
//

import UIKit
import CoreData
import YandexMobileMetrica

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores { persistantStore, error in
            if let error = error {
                assertionFailure("failure loadPersistentStores")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        let context = persistantContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "a1ac7d66-b0b4-4b45-8110-ebf420eff241")
            YMMYandexMetrica.activate(with: configuration!)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

