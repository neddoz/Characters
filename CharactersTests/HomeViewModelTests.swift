//
//  HomeViewModelTests.swift
//  CharactersTests
//
//  Created by kayeli dennis on 18/08/2024.
//

import XCTest
@testable import Characters

final class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    
    func testUpdatesState() {
        sut.didUpdateState = { state in
            XCTAssertTrue(state == .loading)
        }
        sut.updateState(to: .loading)
    }

    func testComputesAccurately() {
        sut.fetchCharacters()

        XCTAssertEqual(sut.numberOfItemsInSection(), 1)
        XCTAssertEqual(sut.character(at: 0).origin.name, "Nairobi")
    }

    func tesFiltersWorkAccurately() {
        
    }

    override func setUp() {
        sut = HomeViewModel(networkService: MockNetworkService())
    }

    override func tearDown() {
        sut = nil
    }
}
