//
//  ListTableViewCell.swift
//  PlanApp
//
//  Created by 1 on 2023/01/24.
//

import UIKit

class ListCell: UITableViewCell {
    lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
   
    lazy var timeLabel :UILabel =  {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configure()

    }
        
    private func configure() {
        contentView.addSubview(mainImage)
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        mainImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 10).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 10).isActive = true


        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant: 10).isActive = true
//        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: mainImage.trailingAnchor, constant: 10).isActive = true

        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        timeLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 10).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10).isActive = true
//        timeLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    
    
}
