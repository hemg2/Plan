//
//  ListViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/23.
//

import UIKit

final class ListViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private var list = [ListModel]()
    private var tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    lazy var navButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "기록하기", style: .plain, target: self, action: #selector(recordVC))
        button.tintColor = .black
        return button
    }()
 
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = navButton
        tableViewLayout()
        tableViewExtension()
        title = "예시"
    }
    
    private func tableViewLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
//        tableView.estimatedRowHeight = UITableView.automaticDimension
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 200
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }
        cell.titleLabel.text = "타이틀라벨"
        cell.descriptionLabel.text = "디스크립션"
        return cell
     }
    
    
}

extension ListViewController: UITableViewDelegate {
    
}

