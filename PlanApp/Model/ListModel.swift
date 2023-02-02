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
    
    
    init(mainImageData: Data?, title: String, description: String, date: Date) {
        self.mainImageData = mainImageData
        self.title = title
        self.description = description
        self.date = date
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case mainImageData
        case date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.mainImageData = try container.decodeIfPresent(Data.self, forKey: .mainImageData)
        self.date = try container.decode(Date.self, forKey: .date)
    }
    
}

extension ListModel: Comparable {
    static func < (lhs: ListModel, rhs: ListModel) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func == (lhs: ListModel, rhs: ListModel) -> Bool {
        return lhs.title == rhs.title
    }
}


struct TagetModel {
    let title: String
    let description: String
    let date: Date
}
