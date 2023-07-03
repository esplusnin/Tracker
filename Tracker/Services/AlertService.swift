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
            title = LocalizableConstants.AlertsVC.removeCategoryTitle
            message = LocalizableConstants.AlertsVC.removeCategoryMessage
        case .removeTracker:
            title = LocalizableConstants.AlertsVC.removeTrackerTitle
        }
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: LocalizableConstants.AlertsVC.cancel, style: .cancel)
        let remove = UIAlertAction(title: LocalizableConstants.AlertsVC.remove, style: .destructive) { _ in
            completion()
        }
        
        alert.addAction(cancel)
        alert.addAction(remove)
        
        controller.present(alert, animated: true)
    }
}
