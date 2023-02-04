//
//  List.swift
//  PlanApp
//
//  Created by 1 on 2023/01/24.
//

import UIKit


struct ListModel: Codable {
    let mainImageData: Data?
    let title: String
    let description: String
    let date: Date
}


struct DateModel {
    let title: String
    let description: String
}



enum Dream: Equatable {
    case list
    case date
}
