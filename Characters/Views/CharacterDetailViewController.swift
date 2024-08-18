//
//  CharacterDetailViewController.swift
//  Characters
//
//  Created by kayeli dennis on 18/08/2024.
//

import UIKit
import SwiftUI

class CharacterDetailViewController: UIViewController {

    let character: Character
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createHostingController(character: self.character)
    }
    
    private func createHostingController(character: Character) {
        
        let detailView = CharacterDetailView(character: character)
        
        let hostingController = UIHostingController(rootView: detailView)

        hostingController.sizingOptions = .intrinsicContentSize

        addChild(hostingController)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        hostingController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            hostingController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            hostingController.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Custom back button setup
        setupCustomBackButton()
    }
    
    private func setupCustomBackButton() {
        let backButton = CustomBackButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Create a container view to hold the button
        let backButtonContainer = UIView(frame: backButton.bounds)
        backButtonContainer.addSubview(backButton)
        
        // Use `UIBarButtonItem` with custom view
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
