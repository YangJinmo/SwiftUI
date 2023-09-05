//
//  ListableResponseModel.swift
//  Utils
//
//  Created by Jmy on 2023/09/04.
//

import SwiftUI

protocol ListableResponseModel: Codable, Identifiable {
    var titleString: String { get }
    var subtitleString: String? { get }
    var detailString: String? { get }
    var sectionIdentifiers: [String]? { get }
    var sectionKey: KeyPath<Self, String>? { get }
}

extension ListableResponseModel {
    var subtitleString: String? {
        return nil
    }

    var detailString: String? {
        return nil
    }

    var sectionIdentifiers: [String]? {
        return nil
    }

    var sectionKey: KeyPath<Self, String>? {
        return nil
    }
}

extension PhoneModel {
    var titleString: String {
        return name ?? ""
    }

    var subtitleString: String? {
        return "Released \(releaseDate ?? "")"
    }

    var detailString: String? {
        return "\(screenResolution?.height ?? 0)x\(screenResolution?.width ?? 0)"
    }
}

extension PrimeMinister {
    var titleString: String {
        return name ?? ""
    }

    var detailString: String? {
        return party
    }

    var sectionIdentifiers: [String]? {
        return ["Whig", "Conservative", "Labour"]
    }

    var sectionKey: KeyPath<PrimeMinister, String>? {
        return \.party
    }
}
