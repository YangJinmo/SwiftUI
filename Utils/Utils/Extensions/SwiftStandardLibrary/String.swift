//
//  String.swift
//  Utils
//
//  Created by Jmy on 2023/06/20.
//

import Foundation

extension String {
    // let stringFromInt: String = String(intTypeNumber: 20000) // "20000"
    init(intTypeNumber: Int) {
        self = "\(intTypeNumber)"
    }

    // let stringFromDouble: String = String(doubleTypeNumber: 3.14159) // "3.14159"
    init(doubleTypeNumber: Double) {
        self = "\(doubleTypeNumber)"
    }

    // let stringFromFloat: String = String(floatTypeNumber: 3.14159) // "3.14159"
    init(floatTypeNumber: Float) {
        self = "\(floatTypeNumber)"
    }

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

    var encode: String? {
        var allowedQueryParamAndKey: CharacterSet = .urlQueryAllowed // ! $ & \ ( ) * +  - . / : ; = ? @ _ ~
        allowedQueryParamAndKey.insert("#")
        return addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey)
    }

    var isUpdate: Bool {
        return compare(Bundle.appVersion, options: .numeric) == .orderedDescending
    }

    var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    // MARK: - Log

    public enum LogTrait: String {
        case app = "☄️"
        case verbose = "🔬"
        case debug = "💬"
        case info = "ℹ️"
        case warning = "⚠️"
        case error = "🔥"
    }

    func log(trait: LogTrait = LogTrait.info, filename: String = #file, line: Int = #line, function: String = #function, _ comment: String = "") {
        print("\(trait.rawValue) \(Date().toString()) [\(filename.source):\(line)] \(function) \(comment)\(self)")
    }

    var source: String {
        let components = components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!.components(separatedBy: ".").first!
    }

    // MARK: - Localized

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    // MARK: - Date

    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current // TimeZone(abbreviation: "GMT")
        dateFormatter.locale = .current // Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }

    func isValidDate(format: String = "yyyy.MM.dd") -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current // TimeZone(abbreviation: "GMT")
        dateFormatter.locale = .current // Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) != nil
    }

    func isValidDateUpToToday(format: String = "yyyy.MM.dd") -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current // TimeZone(abbreviation: "GMT")
        dateFormatter.locale = .current // Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = format

        guard let date = dateFormatter.date(from: self) else {
            return false
        }

        let currentDate = Date()
        let calendar = Calendar.current
        let comparison = calendar.compare(date, to: currentDate, toGranularity: .day)

        return comparison != .orderedDescending
    }
}
