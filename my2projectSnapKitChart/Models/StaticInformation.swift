//
//  StaticInformation.swift
//  my2projectSnapKitChart
//
//  Created by Home on 23.01.2023.
//

import Foundation
// MARK: - Statistics - FOR JSON DECODING
struct Statistics: Codable {
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let records: [Record]?
}

// MARK: - Record
struct Record: Codable {
    let date: String?
    let day: Int?
    let resource: String?
    let stats: [String: Int]?
}





struct StaticInformation {
    static let shared = StaticInformation()
    
    let termsUA = ["Особовий склад",
               "Танки",
               "Бойові броньовані машини",
               "Артилерійські системи",
               "Реактивні системи залпового вогню",
               "Системи протиповітряної оборони",
               "Літаки",
               "Гелікоптери",
               "Автомобільна техніка та цистерни з ПММ",
               "Військові кораблі та катери",
               "Безпілотні літальні апарати",
               "Спец. техніка",
               "Оперативно-тактичні ракетні комплекси та тактичні ракетні комплекси",
               "Крилаті ракети"
    ]
    let termsEN = ["personnel_units",
               "tanks",
               "armoured_fighting_vehicles",
               "artillery_systems",
               "mlrs",
               "aa_warfare_systems",
               "planes",
               "helicopters",
               "vehicles_fuel_tanks",
               "warships_cutters",
               "uav_systems",
               "special_military_equip",
               "atgm_srbm_systems",
               "cruise_missiles"
    ]
    
    
    
}
