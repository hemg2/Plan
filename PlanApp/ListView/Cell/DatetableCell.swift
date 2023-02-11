//
//  TargetCell.swift
//  PlanApp
//
//  Created by 1 on 2023/01/30.
//

import UIKit

protocol DateDelegate: AnyObject {
    func didSelectItemAt(index: Int, selectedDate: Date)
}

final class DatetableCell: UITableViewCell {
    
    private let now = Date()
    private var totalDay = [Date]()
    private var selectedDate = Date()
    weak var delegate: DateDelegate?
    private let list = [ListModel]()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    func setWeekView() {
        let todayDate = Date()
        totalDay.removeAll()
        let currentMonthCount = CalendarHelper().daysInMonth(date: todayDate)
        var startDay = todayDate.startOfMonth()
        for _ in 1...currentMonthCount {
            totalDay.append(startDay)
            startDay = CalendarHelper().addDays(date: startDay, days: 1)
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
        contentView.clipsToBounds = false
        clipsToBounds = false
        
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
        
        let date = totalDay[indexPath.row]
        cell.setData(date: date)
        return cell
    }
    
    
    
}


extension DatetableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 45, height: 45)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalDay[indexPath.row]
        collectionView.reloadData()
        delegate?.didSelectItemAt(index: indexPath.row, selectedDate: selectedDate)
        
        
        print("-----------------collection view select--------------------")
//        print("\(indexPath) collection view indexPath")
//        print("\(selectedDate) collection view selectedDate 내가 선택한 날짜가뜬다")
        print("-------------------------------------")
    }
}


extension DatetableCell: UICollectionViewDelegate {
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    //    }
    
    /// 그리드의 항목 줄 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    /// 같은 행에 있는 항목 사이에 사용할 최소 간격
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 5.0
    //    }
}
