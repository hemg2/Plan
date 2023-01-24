//
//  RecordViewController.swift
//  PlanApp
//
//  Created by 1 on 2023/01/24.
//

import UIKit
import MobileCoreServices

enum VideoHelper {
    static func startMediaBrowser(
        delegate: UIViewController & UINavigationControllerDelegate & UIImagePickerControllerDelegate,
        sourceType: UIImagePickerController.SourceType
    ) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType)
        else { return }

        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = sourceType
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        delegate.present(mediaUI, animated: true, completion: nil)
    }
}


class RecordViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonLayout()
    }
    
    
    func buttonLayout() {
        let button = UIButton()
        button.setTitle("사진첩", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
//        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        button.addTarget(self, action: #selector(keepPhoto), for: .touchUpInside)
        
    }

    // 사진첩
    @objc private func keepPhoto() {
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    }
}
