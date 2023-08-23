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
    
    private func layoutdata() {
        backgroundColor = .white
        layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 3
        
        layer.shadowColor =  UIColor.init(red: 30/255, green: 30/255, blue: 30/255, alpha: 1).cgColor
        layer.shadowOffset = .init(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 1
        
        contentView.addSubview(weekLabel)
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        weekLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 5).isActive = true
        weekLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.topAnchor.constraint(equalTo:weekLabel.bottomAnchor, constant: 5).isActive = true
        dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    func setData(date: Date) {
        weekLabel.text = String(CalendarHelper().dayOfMonth(date: date))
        dayLabel.text = CalendarHelper.getDayOfWeek(date: date)
        
        let weekDay = CalendarHelper().weekDay(date: date)
        if weekDay == 0 {
            weekLabel.textColor = .red
            dayLabel.textColor = .red
        } else if weekDay == 6 {
            weekLabel.textColor = .blue
            dayLabel.textColor = .blue
        } else {
            weekLabel.textColor = .black
            dayLabel.textColor = .black
        }
    }
}
