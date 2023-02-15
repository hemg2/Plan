//
//  MonthCell.swift
//  PlanApp
//
//  Created by 1 on 2023/02/12.
//

import UIKit


final class MonthCell: UITableViewCell {
    
    var selectedDate = Date()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
        button.addTarget(self, action: #selector(nextWeek), for: .touchUpInside)
        return button
    }()
    
    lazy var agoButton: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        button.addTarget(self, action: #selector(agoWeek), for: .touchUpInside)
        return button
    }()
    
    @objc private func nextWeek() {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7) // 실패
    }
    
    @objc private func agoWeek() {
        
    }
    
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
        
        
        contentView.addSubview(agoButton)
        agoButton.translatesAutoresizingMaskIntoConstraints = false
        agoButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        agoButton.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10).isActive = true
        
        contentView.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
    }
    
}
