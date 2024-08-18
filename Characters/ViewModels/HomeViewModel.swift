//
//  HomeViewModel.swift
//  Characters
//
//  Created by kayeli dennis on 16/08/2024.
//

import Foundation
import Combine

enum ViewModelState: Equatable {
    case loading
    case error(String)
    case fetchingNextPaginatedData
    case none
}

final class HomeViewModel {
    var didUpdateState: ((ViewModelState) -> Void)?
    var networkService: NetworkServiceProtocol
    var activeFilters: [CharacterFilter] = []
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    private var characters: [Character] = []
    private var pageInfo: Info?

    func fetchCharacters(params: [String: String] = [:]) {
        
        Task {
            var params = params
            for filter in activeFilters {
                params["status"] = filter.rawValue.lowercased()
            }

            do {
                updateState(to: .loading)
                let result = try await networkService.fetchCharacters(params: params)
                self.characters = result.results
                self.pageInfo = result.info
                updateState(to: .none)
            } catch {
                updateState(to: .error(error.localizedDescription))
            }
        }
    }
    
    func loadMoreCharactersIfNeeded(currentIndex: Int) {
        Task {
            if currentIndex == characters.count - 1 && pageInfo?.next != nil  {
                var params: [String: String] = [:]
                
                if let urlComponents = URLComponents(string: pageInfo?.next ?? ""),
                   let queryItems = urlComponents.queryItems {
                    for item in queryItems {
                        params[item.name] = item.value
                    }
                    print("Query parameters: \(params)")
                }
                
                do {
                    updateState(to: .loading)
                    let result = try await networkService.fetchCharacters(params: params)
                    self.characters.append(contentsOf: result.results)
                    self.pageInfo = result.info
                    updateState(to: .none)
                } catch {
                    updateState(to: .error(error.localizedDescription))
                }
            }
        }
    }
    
    func updateState(to state: ViewModelState) {
        Task { @MainActor [weak self] in
            self?.didUpdateState?(state)
        }
    }

    func numberOfItemsInSection() -> Int {
        return characters.count
    }
    
    func character(at row: Int) -> Character {
        return self.characters[row]
    }
}
