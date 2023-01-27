//
//  ListViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/23.
//

import UIKit

final class ListViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
    lazy var navButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "기록하기", style: .plain, target: self, action: #selector(recordVC))
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
        self.navigationItem.rightBarButtonItem = navButton
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
    
    
    private func saveList() {
        let date = self.list.map {
            [
                "title": $0.title,
                "description": $0.description,
                "mainImage": $0.mainImage
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "list")
    }
    
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
    
}

extension ListViewController: ListViewDelegate {
    func didSelctReigster(list: ListModel) {
        self.list.append(list)
        self.tableView.reloadData()
    }
    
    
}


extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }
        
        let lists = self.list[indexPath.row]
        cell.titleLabel.text = lists.title
        cell.descriptionLabel.text = lists.description
        cell.mainImage.image = lists.mainImage
        cell.timeLabel.text = self.dateToString(date: lists.date)
        return cell
    }
    
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

extension ListViewController: UITableViewDelegate {
    
}

