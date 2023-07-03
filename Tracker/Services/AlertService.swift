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
            title = LocalizableConstants.Alerts.removeCategoryTitle
            message = LocalizableConstants.Alerts.removeCategoryMessage
        case .removeTracker:
            title = LocalizableConstants.Alerts.removeTrackerTitle
        }
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: LocalizableConstants.Alerts.cancel, style: .cancel)
        let remove = UIAlertAction(title: LocalizableConstants.Alerts.remove, style: .destructive) { _ in
            completion()
        }
        
        alert.addAction(cancel)
        alert.addAction(remove)
        
        controller.present(alert, animated: true)
    }
}
