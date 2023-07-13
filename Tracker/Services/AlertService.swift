//
//  AlertService.swift
//  Tracker
//
//  Created by Евгений on 03.07.2023.
//

import UIKit

enum ContextEvent {
    case removeCategory
    case removeTracker
}

final class AlertService {
    
    func showAlert(event: ContextEvent,
                   controller: UIViewController,
                   completion: @escaping (() -> Void)) {
        
        var title: String?
        var message: String?
        
        switch event {
        case .removeCategory:
            title = L10n.Alert.RemoveCategory.title
            message = L10n.Alert.RemoveCategory.message
        case .removeTracker:
            title = L10n.Alert.RemoveTracker.title
        }
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: L10n.Alert.cancel, style: .cancel)
        let remove = UIAlertAction(title: L10n.Alert.remove, style: .destructive) { _ in
            completion()
        }
        
        alert.addAction(cancel)
        alert.addAction(remove)
        
        controller.present(alert, animated: true)
    }
}
