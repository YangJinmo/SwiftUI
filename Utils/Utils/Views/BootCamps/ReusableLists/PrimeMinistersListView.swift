//
//  PrimeMinistersListView.swift
//  Utils
//
//  Created by Jmy on 2023/09/04.
//

import SwiftUI

let primeMinisters: [PrimeMinister] = [
    PrimeMinister(name: "Sir Robert Walpole", term: PrimeMinister.Term(start: "1721-04-03", end: "1742-02-11"), party: "Whig"),
    PrimeMinister(name: "Arthur Balfour", term: PrimeMinister.Term(start: "1902-07-12", end: "1905-12-04"), party: "Conservative"),
]

struct PrimeMinistersListView: View {
    var body: some View {
        List(primeMinisters) {
            Text($0.name ?? "")
        }
    }
}

struct PrimeMinistersListView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeMinistersListView()
    }
}
