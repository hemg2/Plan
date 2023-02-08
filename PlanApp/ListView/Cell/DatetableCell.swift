//
//  TargetCell.swift
//  PlanApp
//
//  Created by 1 on 2023/01/30.
//

import UIKit

final class DatetableCell: UITableViewCell {
    
    private let now = Date()
    private var totalDay = [Date]()
    private var selectedDate = Date()
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
      return collectionView
    }()

//    lazy var nextButton: UIButton = {
//        let button = UIButton()
//        button.setTitle(nil, for: .normal)
//        button.setImage(UIImage(systemName: "arrowshape.forward.fill"), for: .normal)
//        button.addTarget(self, action: #selector(nextButton(_:)), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var previousWeekButton: UIButton = {
//        let button = UIButton()
//        button.setTitle(nil, for: .normal)
//        button.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
//        button.addTarget(self, action: #selector(previousWeekButton(_:)), for: .touchUpInside)
//        return button
//    }()
//
//    @objc func nextButton(_ sender: UIButton) {
//        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
//        setWeekView()
//    }
//
//    @objc func previousWeekButton(_ sender: UIButton) {
//        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
//        setWeekView()
//    }
    
    
    func setWeekView() {
        totalDay.removeAll()
        var current = CalendarHelper().sundayForDate(date: now)
        let nextSunday = CalendarHelper().addDays(date: current, days: 28)
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
        
//        contentView.addSubview(nextButton)
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        nextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
//
//        contentView.addSubview(previousWeekButton)
//        previousWeekButton.translatesAutoresizingMaskIntoConstraints = false
//        previousWeekButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        previousWeekButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
    }
    
    /// 요일 함수
    private func getDayOfWeek(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        formatter.locale = Locale(identifier:"ko_KR")
        let convertStr = formatter.string(from: date)
        return convertStr
    }

    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    
}


extension DatetableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionCell", for: indexPath) as? DateCollectionCell else { return UICollectionViewCell() }
       
        
        let date = totalDay[indexPath.row]
        cell.weekLabel.text = String(CalendarHelper().dayOfMonth(date: date))
        cell.dayLabel.text = getDayOfWeek(date: date)
        cell.backgroundColor = .green
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
        selectedDate = totalDay[indexPath.row]
        
//        let lists = self.list[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "\(selectedDate)"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        //        let date = dateFormatter.date(from: "\(selectedDate)")
        let dateString = dateFormatter.string(from: selectedDate)
        
        let dateFormatters = DateFormatter()
        let a: [()] = list.map {
            dateFormatters.dateFormat = "\($0.date)"
            dateFormatters.string(from: $0.date)
        }
        
        if dateFormatter == dateFormatters {
            DatetableCell().collectionView.reloadData()
            ListViewController().tableView.reloadData()
        }
        print("\(a)1번aaa table date 스트링 값")
        print("\(dateString)2번 collection date 스트링 값")
        print("\(selectedDate)셀렉션")
        print("\(indexPath)클릭")
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
