//
//  RecordViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/24.
//

import UIKit
import Photos

protocol ListViewDelegate: AnyObject {
    func didSelctReigster(list: ListModel)
}

final class RecordViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let imagePickerController = UIImagePickerController()
    weak var delegate: ListViewDelegate?
    private let datePicker = UIDatePicker()
    private var listDate: Date?
    var listEditorMode: ListEditorMode = .new
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .darkGray
        return image
    }()
    
    lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.text = "사진"
        return label
    }()
    
    lazy var imageButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진추가하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(keepPhoto), for: .touchUpInside)
        return button
    }()
    
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
        textField.frame = CGRect(x: 0, y: 0, width: 400, height: 40)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
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
        view.backgroundColor = .systemBackground
        imagePickerController.delegate = self
        navigations()
        layout()
        imageViews()
        dateLayout()
        configureDatePicker()
        configureEditorMode()
    }
    
    private func configureEditorMode() {
        switch self.listEditorMode {
        case let .edit(_, list):
            if let mainImageData = list.mainImageData {
                self.imageView.image = UIImage(data: mainImageData)
            }
            self.titleTextField.text = list.title
            self.descriptionTextField.text = list.description
            self.dateTextField.text = self.dateToString(date: list.date)
            self.listDate = list.date
            self.naviBarButton.title = "수정"
            
        default: break
        }
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


extension RecordViewController {
    @objc private func keepPhoto() {
        let alert = UIAlertController(title: "알림", message: "선택해주세요", preferredStyle: UIAlertController.Style.alert)
        
        let selrect = UIAlertAction(title: "사진촬영", style: UIAlertAction.Style.default) { (_) in
            let camera = UIImagePickerController()
            camera.delegate = self
            camera.sourceType = .camera
            camera.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
            camera.allowsEditing = false
            self.present(camera, animated: true)
        }
        
        let pictrue = UIAlertAction(title: "사진선택", style: UIAlertAction.Style.destructive) { (_) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        
        alert.addAction(selrect)
        alert.addAction(pictrue)
        alert.addAction(cancelAction)
        self.present(alert, animated: false)
    }
    
    @objc private func add() {
        guard let title = self.titleTextField.text else { return }
        guard let description = self.descriptionTextField.text else { return }
        guard let mainImage = self.imageView.image else { return }
        guard let date = self.listDate else { return }
        let list = ListModel(mainImageData: mainImage.pngData(), title: title, description: description, date: date)
        
        switch self.listEditorMode {
        case .new:
            self.delegate?.didSelctReigster(list: list)
        case let .edit(indexPath, _):
            NotificationCenter.default.post(name: NSNotification.Name("List"), object: list, userInfo: [
                "indexPath.row": indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func savedImage(image: UIImage, didFinishSavingWithError: Error?, error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        if let error = error {
            print(error)
            return
        }
        print("success사진")
    }
}

extension RecordViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = image
        }
        
        if let images = info[.originalImage] as? UIImage {
            UIImageWriteToSavedPhotosAlbum(images, self, #selector(savedImage), nil)
        }
        
        if let url = info[.mediaURL] as? URL, UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
            }, completionHandler: { (success, error) in
                if success {
                    print("success동영상")
                } else if let error = error {
                    print(error)
                }
            })
        }
        picker.dismiss(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
