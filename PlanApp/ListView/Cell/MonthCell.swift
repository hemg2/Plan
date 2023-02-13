//
//  MonthCell.swift
//  PlanApp
//
//  Created by 1 on 2023/02/12.
//

import UIKit


final class MonthCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        layout()
    }
    
    func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
