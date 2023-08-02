//
//  Dictionary.swift
//  Utils
//
//  Created by Jmy on 2023/08/02.
//

extension Dictionary {
    func queryPrint() {
        for (key, value) in self {
            print(" - \(key): \(value)")
        }
    }

    func prettyPrint(prefixLetter: String = "\t") {
        print()
        print("[")

        for (key, value) in self {
            print("\(prefixLetter)\(key): \(value)")
        }

        print("]")
        print()
    }

    func printAnyObject() {
        print(self as AnyObject)
    }
}
