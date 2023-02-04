//
//  DateCollectionCell.swift
//  PlanApp
//
//  Created by 1 on 2023/02/04.
//

import UIKit

class DateCollectionCell: UICollectionViewCell {
    static let id = "DateCollectionCell"
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var subTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 5).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true

        contentView.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant: 5).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -5).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
