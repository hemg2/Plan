//
//  RecordViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/24.
//

import UIKit


final class RecordViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let imagePickerController = UIImagePickerController()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBackground
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
        button.setImage(UIImage(systemName: "plus"), for: .normal)
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
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 100, y: 100, width: 400, height: 30)
        textField.borderStyle = .roundedRect
        textField.placeholder = "제목을 입력해주세요."
        return textField
    }()
    
    lazy var textView: UITextField = {
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
        let button = UIBarButtonItem(title:"사진첩", style: .plain, target: self, action: #selector(keepPhoto))
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigations()
        layout()
        imageViews()
    }
    
    func navigations() {
        view.backgroundColor = .systemBackground
        title = "기록하기"
        self.navigationItem.rightBarButtonItems = [naviButton, naviBarButton]
    }
    
    func imageViews() {
        view.addSubview(imageLabel)
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 15).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(imageButton)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        imageButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func layout() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 250).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        view.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 10).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
    }
}



extension RecordViewController {
    @objc func cameraVC(_ sender: UIBarButtonItem) {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        camera.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
        camera.allowsEditing = false
        self.present(camera, animated: true)
    }
    
    // 사진첩
    @objc private func keepPhoto() {
        //enum VideoHelper {
        //    static func startMediaBrowser(
        //        delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate,
        //        sourceType: UIImagePickerController.SourceType
        //    ) {
        //        guard UIImagePickerController.isSourceTypeAvailable(sourceType)
        //        else { return }
        //
        //        let mediaUI = UIImagePickerController()
        //        mediaUI.sourceType = sourceType
        //        mediaUI.mediaTypes = [kUTTypeMovie as String]
        //        mediaUI.allowsEditing = true
        //        mediaUI.delegate = delegate
        //        delegate.present(mediaUI, animated: true, completion: nil)
        //    }
        //}
        //        VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum) 영상 불러오기
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }
}
