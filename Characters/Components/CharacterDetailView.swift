//
//  CharacterDetailView.swift
//  Characters
//
//  Created by kayeli dennis on 18/08/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    @Environment(\.dismiss) var dismiss

    let character: Character
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.image?.resizable()
                        .scaledToFill()
                }
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    )
                )
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()

                //  Name, gender and status
                HStack {
                    VStack {
                        Text(character.name)
                            .foregroundStyle(Color.black)
                            .font(
                                .title2.weight(.bold)
                            )
                        HStack {
                            Text(character.species)
                                .foregroundStyle(Color.gray)
                                .font(
                                    .body.weight(.semibold)
                                )
                            
                            Text(".")
                            
                            Text(character.gender)
                                .foregroundStyle(Color.gray)
                                .font(
                                    .body.weight(.semibold)
                                )
                        }
                    }
                    
                    Spacer()
                    
                    Text(character.status.rawValue)
                        .frame(width: 80, height: 30)
                        .background(Color.blue)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 12,
                                style: .continuous
                            )
                        )
                        .padding()
                }
                .padding(.leading, 10)

                
                // Location
                HStack {
                    Text("Location : ")
                    Text(character.location.name)
                    Spacer()
                }
                .padding(.leading, 10)
                
            }
            .frame(height: reader.size.height * 0.5)
            .padding(.trailing, 0)
            .padding(.leading, 0)
        }
        .navigationBarBackButtonHidden(true)
    }
}
