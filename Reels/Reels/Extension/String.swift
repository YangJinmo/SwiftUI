//
//  String.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import Foundation

extension String {
    var toURL: URL? {
        guard !isEmpty else {
            print("Error: string is Empty")
            return nil
        }

        guard let url = URL(string: self) else {
            print("Error: string is URL not Supported \(self)")
            return nil
        }

        return url
    }
}
