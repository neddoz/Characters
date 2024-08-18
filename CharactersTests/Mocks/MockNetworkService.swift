//
//  MockNetworkService.swift
//  CharactersTests
//
//  Created by kayeli dennis on 18/08/2024.
//

import Foundation

class MockNetworkService: NetworkServiceProtocol {
    func fetchCharacters(params: [String : String]) async throws -> CharacterResult {
        let result = Character(id: 0, name: "Name", status: Status.alive, species: "Human", type: "type", gender: "male", origin: Location(name: "Nairobi", url: ""), location: Location(name: "Kenya", url: "url"), image: "url", episode: [], url: "", created: "")
        return CharacterResult(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: [result])
    }
}
