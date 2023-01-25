//
//  ListViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/23.
//

import UIKit

final class ListViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   
    private var list = [ListModel]() {
        didSet {
            self.saveList()
        }
    }
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
        loadList()
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: NSNotification.Name("list"), object: nil)
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
//        tableView.estimatedRowHeight = UITableView.automaticDimension
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.rowHeight = 200
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func tableViewExtension() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "list") as? [[String: Any]] else { return }
        self.list = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let description = $0["description"] as? String else { return nil }
            guard let mainImage = $0["mainImage"] as? UIImage else { return nil }
            return ListModel(mainImage: mainImage, title: title, description: description)
        }
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
    
    @objc func recordVC(_ sender: UIBarButtonItem) {
        let vc = RecordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let title = notification.object as? ListModel else { return }
        guard let description = notification.userInfo?["indexPath.row"] as? Int else { return }
        self.list[description] = title
       
        self.tableView.reloadData()
    }
    
}



extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }
        
        let lists = self.list[indexPath.row]
        cell.titleLabel.text = lists.title
        cell.descriptionLabel.text = lists.description
        cell.mainImage.image = lists.mainImage
        cell.timeLabel.text = "시간"
        return cell
     }
    
    
}

extension ListViewController: UITableViewDelegate {
    
}

