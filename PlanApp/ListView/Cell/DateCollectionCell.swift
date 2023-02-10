//
//  DateCollectionCell.swift
//  PlanApp
//
//  Created by 1 on 2023/02/04.
//

import UIKit

final class DateCollectionCell: UICollectionViewCell {
    
    lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    lazy var dayLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutdata()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func layoutdata() {
        
        contentView.addSubview(weekLabel)
        //        [titleLabel, subTitleLabel].forEach {
        //            contentView.addSubview($0)
        //        }
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        weekLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 5).isActive = true
        //        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        //        weekLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        weekLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo:weekLabel.bottomAnchor, constant: 5).isActive = true
        dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        //        subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -5).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
    }
    
    
}
