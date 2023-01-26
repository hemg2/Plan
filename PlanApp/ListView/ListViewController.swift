//
//  ListViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/23.
//

import UIKit

final class ListViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   
    private var list = [List]()
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
    
   
    @objc func recordVC(_ sender: UIBarButtonItem) {
        let vc = RecordViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListViewController: ListViewDelegate {
    func didSelctReigster(list: List) {
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
//        cell.timeLabel.text = "시간"
        return cell
     }
    
    
}

extension ListViewController: UITableViewDelegate {
    
}

