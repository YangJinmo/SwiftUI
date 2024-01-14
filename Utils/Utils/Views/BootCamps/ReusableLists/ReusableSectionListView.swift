//
//  ReusableSectionListView.swift
//  Utils
//
//  Created by Jmy on 2023/09/04.
//

import SwiftUI

struct ReusableSectionListView<L: ListableResponseModel>: View {
    let data: [L]

    private var sectionedData: [ListSection<L>] {
        // Pull out the section identifiers from the data
        // The result will always be the same for each object, so just get the first value
        let sectionIdentifiers = data.first(where: { $0.sectionIdentifiers != nil })?.sectionIdentifiers

        // If there are no section identifiers, we don't need to support multiple sections, so return a single section
        guard let sectionIdentifiers = sectionIdentifiers else {
            return [ListSection(header: nil, data: data, footer: nil)]
        }

        var sections: [ListSection<L>] = []
        sectionIdentifiers.forEach { sectionIdentifier in
            // For each section identifer, map any objects that contains the identifer at set key path
            let sectionData = data.filter {
                if let sectionKey = $0.sectionKey {
                    return $0[keyPath: sectionKey] == sectionIdentifier
                }
                return false
            }

            // Add the mapped data to a new section, using the section identifer as the header
            sections.append(ListSection(header: sectionIdentifier, data: sectionData, footer: nil))
        }

        return sections
    }

    var body: some View {
        List(sectionedData) { section in
            if !section.data.isEmpty {
                Section {
                    ForEach(section.data) { object in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(object.titleString)

                                if let subtitle = object.subtitleString {
                                    Text(subtitle)
                                }
                            }

                            if let detail = object.detailString {
                                Spacer()
                                Text(detail)
                            }
                        }
                    }
                } header: {
                    if let header = section.header {
                        Text(header)
                    }
                } footer: {
                    if let footer = section.footer {
                        Text(footer)
                    }
                }
            }
        }
    }
}

#Preview {
    Group {
        ReusableSectionListView(data: models)
        ReusableSectionListView(data: primeMinisters)
    }
}
