//
//  TargetCell.swift
//  PlanApp
//
//  Created by 1 on 2023/01/30.
//

import UIKit

final class DatetableCell: UITableViewCell {
    
    let now = Date()
    let cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0
    var totalDay = [Date]()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
//      layout.minimumLineSpacing = 8.0
//      layout.minimumInteritemSpacing = 0
//      layout.itemSize = .init(width: 300, height: 120)
      return layout
    }()
    
    lazy var collectionView: UICollectionView = {
      let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
//      view.isScrollEnabled = true
//      view.showsHorizontalScrollIndicator = false
//      view.showsVerticalScrollIndicator = true
//      view.contentInset = .zero
//      view.backgroundColor = .clear
//      view.clipsToBounds = true
//      view.register(DateCollectionCell.self, forCellWithReuseIdentifier: "DateCollectionCell")
      return view
    }()

    func setWeekView()
    {
        totalDay.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: now)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday)
        {
            totalDay.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
//        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
//            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
//        tableView.reloadData()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        setWeekView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configure()
        setWeekView()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setWeekView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DateCollectionCell.self, forCellWithReuseIdentifier: "DateCollectionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

    }
}



extension DatetableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionCell", for: indexPath) as? DateCollectionCell else { return UICollectionViewCell() }
       
        
        let date = totalDay[indexPath.item]
        
        cell.weekLabel.text = String(CalendarHelper().dayOfMonth(date: date))
        cell.dayLabel.text = "데이"
//        switch indexPath.section {
//        case 0:
//            cell.weekLabel.text = weeks[indexPath.row]
//        default:
//            cell.weekLabel.text = days[indexPath.row]
//        }
//
        if indexPath.row % 7 == 0 {
            cell.weekLabel.textColor = .red
        } else if indexPath.row % 7 == 6 {
            cell.weekLabel.textColor = .blue
        } else {
            cell.weekLabel.textColor = .black
        }
        
        return cell
    }
    
    
    
}


extension DatetableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}
