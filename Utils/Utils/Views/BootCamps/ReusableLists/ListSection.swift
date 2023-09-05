//
//  ListSection.swift
//  Utils
//
//  Created by Jmy on 2023/09/04.
//

import SwiftUI

struct ListSection<L: ListableResponseModel>: Identifiable {
    let id = UUID()
    let header: String?
    let data: [L]
    let footer: String?
}
