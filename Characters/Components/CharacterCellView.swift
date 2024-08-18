//
//  CharacterCellView.swift
//  Characters
//
//  Created by kayeli dennis on 15/08/2024.
//

import SwiftUI

enum CellColor: CaseIterable {
    case pink
    case blue
    case white
    
    var backgroundColor: Color {
        switch self {
        case .pink:
            return Color.pink.opacity(0.2)
        case .blue:
            return Color.blue.opacity(0.1)
        case .white:
            return Color.white
        }
    }
}

let colors: [CellColor] = CellColor.allCases
struct CharacterCellView: View {
    var character: Character? = nil
    let color: CellColor = colors.randomElement()!
    
    var body: some View {
        ZStack {
            self.color.backgroundColor
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    )
                )
            HStack {
                AsyncImage(url: URL(string: character?.image ?? "")) {image in
                    image.image?.resizable()
                }
                    .frame(width: 80, height: 80)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 10,
                            style: .continuous
                        )
                    )

                VStack(alignment: .leading, spacing: 10) {
                    Text(character?.name ?? "")
                        .foregroundStyle(Color.black)
                        .font(
                            .title2.weight(.bold)
                        )
                    Text(character?.species ?? "")
                        .foregroundStyle(Color.gray)
                        .font(
                            .body.weight(.semibold)
                        )
                }
                Spacer()
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.gray.opacity(0.2), lineWidth: self.color == .white ? 2 : 0)
        )
        }
        
    }
}
