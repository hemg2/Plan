//
//  RecordDetailViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/31.
//

import UIKit
import Photos

enum ListEditorMode {
    case new
    case edit(IndexPath, ListModel)
}


final class RecordDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var list: ListModel?
    var indexPath: IndexPath?
    
    private let imagePickerController = UIImagePickerController()
    private let datePicker = UIDatePicker()
    private var listDate: Date?
    
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
//        button.addTarget(self, action: #selector(keepPhoto), for: .touchUpInside)
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
    
    lazy var titleTextLabel: UILabel = {
        let titleTextLabel = UILabel()
        titleTextLabel.font = UIFont.systemFont(ofSize: 25)
        titleTextLabel.text = ""
        return titleTextLabel
    }()
    
    lazy var descriptionTextLabel: UILabel = {
        let descriptionTextLabel = UILabel()
        descriptionTextLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionTextLabel.text = ""
        return descriptionTextLabel
    }()
    
    
    lazy var dateTextLabel: UILabel = {
        let dateTextLabel = UILabel()
        dateTextLabel.font = UIFont.systemFont(ofSize: 15)
        dateTextLabel.text = ""
        return dateTextLabel
    }()
    
    lazy var naviBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title:"변경하기", style: .plain, target: self, action: #selector(change))
        button.tintColor = .black
        return button
    }()
    
    @objc private func change() {
        let vc = RecordViewController()
        guard let indexPath = self.indexPath else { return }
        guard let list = self.list else { return }
        vc.listEditorMode = .edit(indexPath, list)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        navigations()
        layout()
        imageViews()
        dateLayout()
        configureView()
    }
    
    private func configureView() {
        guard let list = self.list else { return }
        self.imageView.image = list.mainImage
        self.titleTextLabel.text = list.title
        self.descriptionTextLabel.text = list.description
        self.dateTextLabel.text = self.dateToString(date: list.date)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
}


extension RecordDetailViewController {
    @objc func cameraVC(_ sender: UIBarButtonItem) {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        camera.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
        camera.allowsEditing = false
        self.present(camera, animated: true)
    }
    

    
    @objc func savedImage(image: UIImage, didFinishSavingWithError: Error?, error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        if let error = error {
            print(error)
            return
        }
        print("success사진")
    }
}

extension RecordDetailViewController {
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
