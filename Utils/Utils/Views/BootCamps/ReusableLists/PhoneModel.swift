//
//  PhoneModel.swift
//  Utils
//
//  Created by Jmy on 2023/09/04.
//

import SwiftUI

struct PhoneModel: Codable, Identifiable, ListableResponseModel {
    let id = UUID()
    let name: String?
    let releaseDate: String?
    let screenResolution: ScreenResolution?

    enum CodingKeys: String, CodingKey {
        case name
        case releaseDate = "release_date"
        case screenResolution = "screen_resolution"
    }

    struct ScreenResolution: Codable {
        let height: Int?
        let width: Int?
    }
}
