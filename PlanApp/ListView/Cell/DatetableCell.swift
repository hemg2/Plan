//
//  TargetCell.swift
//  PlanApp
//
//  Created by 1 on 2023/01/30.
//

import UIKit

var selectedDate = Date()

final class DatetableCell: UITableViewCell {
    
    let now = Date()
    let cal = Calendar.current
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var totalDay = [Date]()
    let cellMarginSize: CGFloat = 10.0
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0.5
//        layout.minimumInteritemSpacing = 0.5
//      layout.itemSize = .init(width: 300, height: 120)
      return layout
    }()
    
    lazy var collectionView: UICollectionView = {
      let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.backgroundColor = .systemBackground
//      view.isScrollEnabled = true
//      view.showsHorizontalScrollIndicator = false
//      view.showsVerticalScrollIndicator = true
//      view.contentInset = .zero
//      view.clipsToBounds = true
      return view
    }()

    func setWeekView() {
        totalDay.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: now)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        //지난 꿈 x
        while (current < nextSunday)
        {
            totalDay.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        collectionView.reloadData()
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
        super.init(coder: coder)
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
        cell.dayLabel.text = "금"
//        cell.backgroundColor = .green
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 10
        if indexPath.row % 7 == 0 {
            cell.weekLabel.textColor = .red
            cell.dayLabel.textColor = .red
        } else if indexPath.row % 7 == 6 {
            cell.weekLabel.textColor = .blue
            cell.dayLabel.textColor = .blue
        } else {
            cell.weekLabel.textColor = .black
            cell.dayLabel.textColor = .black
        }
        
        return cell
    }
    
    
    
}


extension DatetableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 45, height: 45)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalDay[indexPath.item]
        collectionView.reloadData()
        print("날짜 클릭중")
    }
}


extension DatetableCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    /// 그리드의 항목 줄 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

    /// 같은 행에 있는 항목 사이에 사용할 최소 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5.0
//    }
}
