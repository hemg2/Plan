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
//    {
//        didSet {
//            saveList()
//        }
//    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    lazy var naviRecordButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "할일 등록", style: .plain, target: self, action: #selector(recordVC))
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
//        loadList()
    }
    
    private func navigationItem() {
        view.backgroundColor = .systemBackground
        title = "예시"
        self.navigationItem.rightBarButtonItems = [naviRecordButton, tarGetButton]
    }
    
    private func tableViewLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
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
    
    
//    private func saveList() {
//        let date = self.list.map {
//            [
//                "title": $0.title,
//                "description": $0.description,
//                "mainImage": $0.mainImage
//            ]
//        }
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(date, forKey: "list")
//    }
    
//    func loadList() {
//        let userDefaults = UserDefaults.standard
//        guard let data = userDefaults.object(forKey: "list") as? [[String: Any]]else { return }
//        self.list = data.compactMap {
//            guard let title = $0["title"] as? String else { return }
//            guard let description = $0["description"] as? String else { return }
//            guard let mainImage = $0["mainImage"] as? UIImage else { return }
//            return ListModel(mainImage: mainImage, title: title, description: description)
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
        self.list = self.list.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.tableView.reloadData()
    }
    
    
}



extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }
            
            let lists = self.list[indexPath.row]
            cell.titleLabel.text = lists.title
            cell.descriptionLabel.text = lists.description
            cell.mainImage.image = lists.mainImage
            cell.timeLabel.text = self.dateToString(date: lists.date)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }

            let lists = self.list[indexPath.row]
            cell.titleLabel.text = lists.title
            cell.descriptionLabel.text = lists.description
            cell.mainImage.image = lists.mainImage
            cell.timeLabel.text = self.dateToString(date: lists.date)
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "목표 계획"
        case 1: return "할일 기록"
        default: return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   
    
    
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actions1 = UIContextualAction(style: .normal, title: "삭제", handler: { [weak self] action, view, completionHaldler in completionHaldler(true)
            let cell = self?.list.remove(at: indexPath.row)
            tableView.reloadData()
        })
        actions1.backgroundColor = .systemRed
        
        let actions2 = UIContextualAction(style: .normal, title: "수정", handler: { [weak self] action, view, completionHaldler in completionHaldler(true)
            
        })
        actions2.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [actions1, actions2])
    }
    
}

