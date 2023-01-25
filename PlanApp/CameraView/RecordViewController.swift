//
//  RecordViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/24.
//

import UIKit
import Photos

indirect enum ListModes {
    case new
    case edit(IndexPath, ListModel)
}
protocol ListModeDelegate: AnyObject {
    func didSelectList(listMode: ListModel)
}

final class RecordViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let imagePickerController = UIImagePickerController()
    var listMode: ListModes = .new
    var delegate: ListModeDelegate?
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
        button.setTitle(nil, for: .normal)
//        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(keepPhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.text = "제목"
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.text = "내용"
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 100, y: 100, width: 400, height: 30)
        textField.borderStyle = .roundedRect
        textField.placeholder = "제목을 입력해주세요."
        return textField
    }()
    
    lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 100, y: 100, width: 400, height: 30)
        textField.borderStyle = .roundedRect
        textField.placeholder = "내용을 입력해주세요."
        return textField
    }()
    
    lazy var naviButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:nil, style: .plain, target: self, action: #selector(cameraVC))
        button.image = UIImage(systemName: "camera")
        button.tintColor = .black
        return button
    }()
    
    lazy var naviBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"추가하기", style: .plain, target: self, action: #selector(add))
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        navigations()
        layout()
        imageViews()
    }
}



extension RecordViewController {
    @objc func cameraVC(_ sender: UIBarButtonItem) {  //사진
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        camera.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
        camera.allowsEditing = false
        self.present(camera, animated: true)
    }
    
    // 사진첩
    @objc private func keepPhoto() {
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }
    //추가하기
    @objc private func add() {
//        let vc = ListViewController()
        guard let title = self.titleTextField.text else { return }
        guard let description = self.descriptionTextField.text else { return }
        guard let mainImage = self.imageView.image else { return }
        let list = ListModel(mainImage: mainImage, title: title, description: description)
        
        switch self.listMode {
        case .new:
            self.delegate?.didSelectList(listMode: list)
        case let .edit(indexpath, _):
            NotificationCenter.default.post(name: NSNotification.Name("list"),
                                            object: list,
                                            userInfo: [
                                                "indexPath.row": indexpath.row
                                            ])
            
        }
        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    // 사진 저장1
    @objc func savedImage(image: UIImage, didFinishSavingWithError: Error?, error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        if let error = error {
            print(error)
            return
        }
        print("success사진")
    }
}
