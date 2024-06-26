//
//  Bundle.swift
//  Utils
//
//  Created by Jmy on 2023/08/04.
//

import Foundation.NSBundle

extension Bundle {
    static var appName: String {
        return main.infoDictionary?["CFBundleName"] as? String ?? "Unknown"
    }

    static var appDisplayName: String {
        return main.infoDictionary?["CFBundleDisplayName"] as? String ?? appName
    }

    static var appVersion: String {
        return main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }

    static var appBuild: String {
        return main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    static var identifier: String {
        return main.infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown"
    }

    static var appVersionAndBuild: String {
        return "v \(appVersion) (\(appBuild))"
    }

    static var iconFilePath: String {
        let iconFilename = main.object(forInfoDictionaryKey: "CFBundleIconFile") as! NSString
        let iconBasename = iconFilename.deletingPathExtension
        let iconExtension = iconFilename.pathExtension
        return main.path(forResource: iconBasename, ofType: iconExtension)!
    }
}

import UIKit.UIImage

extension Bundle {
    static var iconImage: UIImage? {
        return UIImage(contentsOfFile: iconFilePath)
    }
}
