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
    func save(_ list: [ListModel], completion: ((Error?) -> Void)? = nil) {
        let collectionPath = "channels/1/thread"
        let collectionListener = Firestore.firestore().collection(collectionPath)
        
        guard let dictionary = list.asDictionary else {
            print("decode error")
            return
        }
        collectionListener.addDocument(data: dictionary) { error in
            completion?(error)
        }
    }
    
    func subscribe(title: String, completion: @escaping (Result<[ListModel], FirestoreError>) -> Void) {
        let collectionPath = "channels/1/thread"
        
        let collectionListener = Firestore.firestore().collection(collectionPath)
    
        
        documentListener = collectionListener
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    completion(.failure(FirestoreError.firestoreError(error)))
                    return
                }
                
                
                var titles = [ListModel]()
                snapshot.documentChanges.forEach { change in
                    switch change.type {
                    case .added, .modified:
                        do {
                            let title = try change.document.data(as: ListModel.self)
                            titles.append(title)
                        } catch {
                            completion(.failure(.decodedError(error)))
                        }
                    default: break
                    }
                }
                print(titles)
                completion(.success(titles))
            }
    }
    
    func removeListener() {
        documentListener?.remove()
    }
    
    
    
}
