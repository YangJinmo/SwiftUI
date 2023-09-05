//
//  PrimeMinister.swift
//  Utils
//
//  Created by Jmy on 2023/09/04.
//

import SwiftUI

struct PrimeMinister: Codable, Identifiable, ListableResponseModel {
    let id = UUID()
    let name: String?
    let term: Term?
    let party: String

    enum CodingKeys: String, CodingKey {
        case name
        case term
        case party
    }

    struct Term: Codable {
        let start: String?
        let end: String?
    }
}
