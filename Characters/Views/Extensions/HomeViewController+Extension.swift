//
//  HomeViewController+Extension.swift
//  Characters
//
//  Created by kayeli dennis on 16/08/2024.
//

import Foundation
import UIKit
import SwiftUI

extension HomeViewController {

    func setUpUI() {
        title = "Characters"
        createHostingControllers()
        setUpStackView()
        setUpCollectionView()
        addLoadingIndicator()
    }

    func addLoadingIndicator() {
        view.addSubview(activityIndicator)
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, layoutEnvironment in
            createListSection(layoutEnvironment)
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)

        collectionView.topAnchor.constraint(equalTo: filtersContainerView.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    private func setUpStackView() {
        // Collect the view from each hosting controller..
        let views: [UIView] = hostingControllers.map { $0.view }
        
        // Add each hosting controller as a child view controller.
        hostingControllers.forEach { addChild($0) }


        for view in views {
            filtersContainerView.addArrangedSubview(view)
        }
        
        view.addSubview(filtersContainerView)

        filtersContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        filtersContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        filtersContainerView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        // Notify each hosting controller that it has now moved to a new parent view controller.
        hostingControllers.forEach { $0.didMove(toParent: self) }
    }

    // Creates a hosting controller for each filter button.
    private func createHostingControllers() {
        let unKnownFilterButton = FilterButton(updateFilter: { state in
            if state == .active {
                self.viewModel?.activeFilters.append(.unknown)
                self.viewModel?.fetchCharacters()
            } else {
                if let index = self.viewModel?.activeFilters.firstIndex(of: .unknown) {
                    self.viewModel?.activeFilters.remove(at: index)
                }
                self.viewModel?.fetchCharacters()
            }
        }, title: CharacterFilter.unknown.rawValue)
        
        let deadFilterButton = FilterButton(updateFilter: { state in
            if state == .active {
                self.viewModel?.activeFilters.append(.dead)
                self.viewModel?.fetchCharacters()
            } else {
                if let index = self.viewModel?.activeFilters.firstIndex(of: .dead) {
                    self.viewModel?.activeFilters.remove(at: index)
                }
                self.viewModel?.fetchCharacters()
            }
        }, title: CharacterFilter.dead.rawValue)
        
        let aliveButton = FilterButton(updateFilter: { state in
            if state == .active {
                self.viewModel?.activeFilters.append(.alive)
                self.viewModel?.fetchCharacters()
            } else {
                if let index = self.viewModel?.activeFilters.firstIndex(of: .alive) {
                    self.viewModel?.activeFilters.remove(at: index)
                }
                self.viewModel?.fetchCharacters()
            }
        }, title: CharacterFilter.alive.rawValue)
        
        let buttons = [aliveButton, deadFilterButton, unKnownFilterButton]
        
        for button in buttons {
            let hostingController = UIHostingController(rootView: button)
            
            // Set the sizing options of the hosting controller so that it automatically updates the
            // intrinsicContentSize of its view based on the ideal size of the SwiftUI content.
            hostingController.sizingOptions = .intrinsicContentSize
            
            hostingControllers.append(hostingController)
        }
    }
}
