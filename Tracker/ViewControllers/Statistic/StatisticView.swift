//
//  StatisticView.swift
//  Tracker
//
//  Created by Евгений on 22.05.2023.
//

import UIKit

final class StatisticView {
    lazy var emptyStatisticImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.statisticIsEmpty
        
        return imageView
    }()
    
    lazy var emptyStatisticLabel: UILabel = {
        let label = UILabel()
        label.text = "Анализировать пока нечего"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.blackDay
        
        return label
    }()
}
