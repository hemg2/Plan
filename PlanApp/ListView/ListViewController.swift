//
//  ListViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/23.
//

import UIKit

class ListViewController: UIViewController {
    private var list = [ListModel]()
    private var tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableViewLayout()
        tableViewExtension()
        title = "예시"
    }
    
    
    func tableViewLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.estimatedRowHeight = UITableView.automaticDimension
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 100
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func tableViewExtension() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}



extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = "타이틀라벨"
        cell.descriptionLabel.text = "디스크립션"
        return cell
     }
    
    
}

extension ListViewController: UITableViewDelegate {
    
}

