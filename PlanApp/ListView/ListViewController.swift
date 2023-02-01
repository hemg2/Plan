//
//  ListViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/23.
//

import UIKit

final class ListViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
    private var targetModel = [TagetModel]()
    private var list = [ListModel]()
    {
        didSet {
            saveList()
        }
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    lazy var naviRecordButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "하루 기록", style: .plain, target: self, action: #selector(recordVC))
        button.tintColor = .black
        return button
    }()
    
    lazy var tarGetButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "목표 등록", style: .plain, target: self, action: #selector(tarGetVC))
        button.tintColor = .black
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem()
        tableViewLayout()
        tableViewExtension()
        loadList()
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("List"), object: nil)
    }
    
    private func navigationItem() {
        view.backgroundColor = .systemBackground
        title = "기록"
        self.navigationItem.rightBarButtonItems = [naviRecordButton, tarGetButton]
    }
    
    private func tableViewLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
//        tableView.register(TargetCell.self, forCellReuseIdentifier: "cell1")
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func tableViewExtension() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    
    private func saveList() {
        let userDefaults = UserDefaults.standard
        let encodedList = try! JSONEncoder().encode(list)
        userDefaults.set(encodedList, forKey: "data")
//        print("저장은 되는건가\(userDefaults.object(forKey: "data"))")
    }

    private func loadList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "data") as? Data else { return }
        let decodedList = try! JSONDecoder().decode([ListModel].self, from: data)
        list = decodedList
//        print("로드데이터\(decodedList)")
    }
    
    
    
    func setUserDefaults(UIImage value: UIImage, _ key: String) {
        let imageData = value.jpegData(compressionQuality: 1.0)
        UserDefaults.standard.set(imageData, forKey: "mainImage")
    }

//    func imageData() {
//        if let imageData = UserDefaults.standard.data(forKey: "mainImage"),
//           let image = UIImage(data: imageData) {
//        }
//    }
    
    
    @objc func recordVC(_ sender: UIBarButtonItem) {
        let vc = RecordViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tarGetVC(_ sender: UIBarButtonItem) {
        let vcs = TarGetViewController()
        vcs.delegate = self
        self.navigationController?.pushViewController(vcs, animated: true)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let list = notification.object as? ListModel else { return }
        guard let row = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.list[row] = list
        self.list = self.list.sorted(by:  {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.tableView.reloadData()
    }
    
}

extension ListViewController: ListViewDelegate {
    func didSelctReigster(list: ListModel) {
        self.list.append(list)
        self.list = self.list.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.tableView.reloadData()
    }
}

extension ListViewController: TarGetViewDelegate {
    func didSelctReigsters(target: TagetModel) {
        self.targetModel.append(target)
        self.targetModel = self.targetModel.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.tableView.reloadData()
    }
    
    
}



extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            self.targetModel.count
//        } else if section == 1 {
//            self.list.count
//        }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }
            
            let lists = self.list[indexPath.row]
            cell.titleLabel.text = lists.title
            cell.descriptionLabel.text = lists.description
            if let mainImageData = lists.mainImageData {
                cell.mainImage.image = UIImage(data: mainImageData)
            }
            cell.timeLabel.text = self.dateToString(date: lists.date)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
//        else if indexPath.section == 1 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }
//
//            let lists = self.list[indexPath.row]
//            cell.titleLabel.text = lists.title
//            cell.descriptionLabel.text = lists.description
//            cell.mainImage.image = lists.mainImage
//            cell.timeLabel.text = self.dateToString(date: lists.date)
//            cell.accessoryType = .disclosureIndicator
//            return cell
//        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RecordDetailViewController()
        let list = self.list[indexPath.row]
        vc.list = list
        vc.indexPath = indexPath
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
//        case 0: return "목표 계획"
        case 0: return "일기 기록"
        default: return nil
        }
    }
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
   
    
    
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actions1 = UIContextualAction(style: .normal, title: "삭제", handler: { [weak self] action, view, completionHaldler in completionHaldler(true)
            self?.list.remove(at: indexPath.row)
            tableView.reloadData()
        })
        actions1.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [actions1])
    }
    
    
}

