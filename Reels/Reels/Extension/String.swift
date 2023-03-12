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

    // 특정 범위의 문자는 문자열[범위]로 가능하다.

    // 첫번째 문자.
    var start: String {
        let c: Character = self[startIndex]
        return String(c)
    }

    // 마지막 문자.
    var end: String {
        let endIndex: Index = index(before: self.endIndex)
        let c: Character = self[endIndex]
        return String(c)
    }

    // 특정 문자의 위치 없는경우 nil 반환 여러개면 맨 처음 검색되는 문자열만 반환.
    func indexLocation(char: String) -> Int? {
        if let charRange: Range<String.Index> = range(of: char) {
            let location: Int = distance(from: startIndex, to: charRange.lowerBound)
            return location
        }
        return nil
    }

    // 현재 문자열에서 찾는 문자까지의 범위. 찾는 문자가 없으면 nil
    func rangeOfString(char: String) -> ClosedRange<String.Index>? {
        let startIndex = self.startIndex
        guard let findIndex = indexLocation(char: char) else {
            return nil
        }
        let endIndex = index(startIndex, offsetBy: findIndex)
        let resultRange = startIndex ... endIndex
        return resultRange
    }

    // 현재 문자열에서 찾는 문자 전까지의 범위. 찾는 문자가 없으면 nil
    func preRangeOfString(char: String) -> ClosedRange<String.Index>? {
        let startIndex = self.startIndex
        guard let findIndex = indexLocation(char: char) else {
            return nil
        }
        let endIndex = index(startIndex, offsetBy: findIndex - 1)
        let resultRange = startIndex ... endIndex
        return resultRange
    }

    // 현재 문자열에서 찾는 문자 전까지의 범위. 찾는 문자가 없으면 nil
    func postRangeOfString(char: String) -> ClosedRange<String.Index>? {
        guard let findIndex = indexLocation(char: char) else {
            return nil
        }
        let startIndex = index(self.startIndex, offsetBy: findIndex + 1)
        let endIndex = index(before: self.endIndex)
        let resultRange = startIndex ... endIndex
        return resultRange
    }

    // a문자부터 b문자까지의 범위
    func rangeOfString(aChar: String, bChar: String) -> ClosedRange<String.Index>? {
        guard let findA = indexLocation(char: aChar) else {
            return nil
        }
        let startIndex = index(self.startIndex, offsetBy: findA)

        guard let findB = indexLocation(char: bChar) else {
            return nil
        }
        let endIndex = index(self.startIndex, offsetBy: findB)
        let resultRange = startIndex ... endIndex
        return resultRange
    }

    // 특정 위치의 문자
    func rangeOfDistance(a: Int, b: Int) -> String {
        let startIndex = index(self.startIndex, offsetBy: a)
        let endIndex = index(self.startIndex, offsetBy: b)
        let c = self[startIndex ... endIndex]
        return String(c)
    }

    // 특정 문자의 위치를 갖고있는 배열을 반환

    // self에서 특정 문자의 범위를 찾는다
    // 특정 문자의 범위로 특정 문자를 찾는다.
    func indexLocations(char: String) -> [Int] {
        let strArr = Array(self)
        let result = strArr.enumerated().filter { (arg: (offset: Int, element: String.Element)) -> Bool in
            String(arg.element) == char
        }.compactMap { (index: Int, _: String.Element) -> Int in
            index
        }
        return result
    }
}
