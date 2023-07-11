//
//  NewCategoryCell.swift
//  Tracker
//
//  Created by Евгений on 25.05.2023.
//

import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    
    weak var delegate: CategoryCellDelegate?
    
    var titleLabel = UILabel()
    var viewModel: String? {
        didSet {
            titleLabel.text = viewModel
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.backgroundDay
        setViews()
        setConstraints()
        addContextMenuInteraction()
    }
    
    private func setViews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
}

extension CategoryCell: UIContextMenuInteractionDelegate {
    func addContextMenuInteraction() {
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let editImage = UIImage(systemName: "square.and.pencil")
        let removeImage = UIImage(systemName: "trash")
        
        return UIContextMenuConfiguration(actionProvider:  { _ in
            let editAction = UIAction(title: L10n.ContextMenu.edit,
                                      image: editImage) { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.editCategory(self)
            }
            let removeAction = UIAction(title: L10n.ContextMenu.remove,
                                        image: removeImage,
                                        attributes: .destructive) { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.removeCategory(self)
            }
            
            return UIMenu(children: [editAction, removeAction])
        })
    }
}

