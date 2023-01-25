//
//  dataHelper.swift
//  my2projectSnapKitChart
//
//  Created by Home on 23.01.2023.
//

import Foundation

struct dataHelper {
    static let shared = dataHelper()
   
    func todayDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd MM yyyy"
        let today = format.string(from: date)
        return today
    }
}
