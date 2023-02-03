//
//  MyFirestore.swift
//  PlanApp
//
//  Created by 1 on 2023/02/02.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class MyFirestore {
    
    private var documentListener: ListenerRegistration?
    
    ///파이어베이스에 데이터 저장 메소드
    func save(_ list: ListModel, completion: ((Error?) -> Void)? = nil) {
        let collectionPath = "channels/\(list.title)/thread"
        let collectionListener = Firestore.firestore().collection(collectionPath)
        
        guard let dictionary = list.asDictionary else {
            print("decode error")
            return
        }
        collectionListener.addDocument(data: dictionary) { error in
            completion?(error)
        }
    }
    
    
    func subscribe(title: String, completion: @escaping (Result<[ListModel], FirestoreErrorCode>) -> Void) {
        let collectionPath = "channels/\(title)/thread"
        
        let collectionListener = Firestore.firestore().collection(collectionPath)
    
        
        documentListener = collectionListener
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    completion(.failure(FirestoreErrorCode.fires(error)))
                    return
                }
                
                
                
            }
        
        
    }
    
    
    
    
    func removeListener() {
        documentListener?.remove()
    }
    
    
    
}
