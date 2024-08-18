//
//  FilterButton.swift
//  Characters
//
//  Created by kayeli dennis on 15/08/2024.
//

import SwiftUI

enum FilterState {
    case active
    case inactive
}

struct FilterButton: View {
    @State var filterState: FilterState = .inactive
    var updateFilter: (FilterState) -> Void?
    var title: String
    
    var body: some View {
        if self.filterState == .active {
            
            Button {
                filterState = self.filterState == .active ? .inactive : .active
                updateFilter(self.filterState)
            } label: {
                Text(title)
                    .foregroundStyle(Color.black)
                    .font(
                        .title2
                    )
            }
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.gray.opacity(0.2), lineWidth: 0)
            )
            .background(Color.blue.opacity(0.4))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
            )

        } else {
            
            Button {
                filterState = self.filterState == .active ? .inactive : .active
                updateFilter(self.filterState)
            } label: {
                Text(title)
                    .foregroundStyle(Color.black)
                    .font(
                        .title2
                    )
            }
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.gray.opacity(0.2), lineWidth: 2)
            )
        }
    }
}

#Preview {
    FilterButton(updateFilter: { state in }, title: CharacterFilter.unknown.rawValue)
}
