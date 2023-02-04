//
//  TargetCell.swift
//  PlanApp
//
//  Created by 1 on 2023/01/30.
//

import UIKit

final class DatetableCell: UITableViewCell {
    
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

    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configure()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionCell", for: indexPath) as? DateCollectionCell else { return UICollectionViewCell() }
        cell.titleLabel.text = "1"
        cell.subTitleLabel.text = "토"
        return cell
    }
    
    
}


extension DatetableCell: UICollectionViewDelegate {
    
}
