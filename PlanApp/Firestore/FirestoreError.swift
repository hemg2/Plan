//
//  FirestoreError.swift
//  PlanApp
//
//  Created by 1 on 2023/02/03.
//

import Foundation

enum FirestoreError: Error {
    case firestoreError(Error?)
    case decodedError(Error?)
}
