//
//  RIPStatistics.swift
//  my2projectSnapKitChart
//
//  Created by Home on 19.01.2023.
//

import UIKit

struct statistics {
    
    struct Welcome: Codable {
        let message: String
        let data: DataClass
    }
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let date: String
        let day: Int
        let resource: String
        let stats, increase: [String: Int]
    }
}
