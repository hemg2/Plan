//
//  TarGetViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/29.
//

import UIKit
import Photos

protocol TarGetViewDelegate: AnyObject {
    func didSelctReigsters(target: TagetModel)
}

class TarGetViewController: UIViewController, UINavigationControllerDelegate {
    
    private let imagePickerController = UIImagePickerController()
    weak var delegate: TarGetViewDelegate?
    private let datePicker = UIDatePicker()
    private var listDate: Date?
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "제목"
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "내용"
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "날짜"
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 100, y: 100, width: 400, height: 40)
        textField.borderStyle = .roundedRect
        textField.placeholder = "제목을 입력해주세요."
        return textField
    }()
    
    lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 100, y: 100, width: 400, height: 40)
        textField.borderStyle = .roundedRect
        textField.placeholder = "내용을 입력해주세요."
        return textField
    }()
    
    
    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 100, y: 100, width: 400, height: 40)
        textField.borderStyle = .roundedRect
        textField.placeholder = "날짜을 입력해주세요."
        return textField
    }()
    
    
    lazy var naviBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"추가하기", style: .plain, target: self, action: #selector(add))
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigations()
        layout()
        dateLayout()
        configureDatePicker()
    }
    
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.dateTextField.inputView = self.datePicker
        self.datePicker.locale = Locale(identifier: "ko_KR")
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
     let formmater = DateFormatter()
        formmater.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formmater.locale = Locale(identifier: "ko_KR")
        self.listDate = datePicker.date
        self.dateTextField.text = formmater.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
}


extension TarGetViewController {
    //추가하기
    @objc private func add() {
        guard let title = self.titleTextField.text else { return }
        guard let description = self.descriptionTextField.text else { return }
        guard let date = self.listDate else { return }
        let taget = TagetModel(title: title, description: description, date: date)
        self.delegate?.didSelctReigsters(target: taget)
        self.navigationController?.popViewController(animated: true)

    }
}

