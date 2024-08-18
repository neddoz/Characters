//
//  ViewController.swift
//  Characters
//
//  Created by kayeli dennis on 14/08/2024.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    let filtersContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = -20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var hostingControllers = [UIHostingController<FilterButton>]()
    
    // A cell registration that configures a custom list cell with a SwiftUI Charactre cell view.
    private var characterCellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Character> = {
        .init { cell, indexPath, item in
            cell.contentConfiguration = UIHostingConfiguration {
                CharacterCellView(character: item)
            }
        }
    }()
    
    var collectionView: UICollectionView!
    
    var viewModel: HomeViewModel? {
        didSet {
            bindViewModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpUI()
        viewModel = HomeViewModel()
        viewModel?.fetchCharacters()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // Returns a compositional layout section for cells in a list.
    func createListSection(_ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.showsSeparators = false
        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        section.contentInsets = .zero
        section.contentInsets.leading = LayoutMetrics.horizontalMargin
        section.contentInsets.trailing = LayoutMetrics.horizontalMargin
        section.contentInsets.bottom = LayoutMetrics.sectionSpacing
        return section
    }

    private struct LayoutMetrics {
        static let horizontalMargin = 0.0
        static let sectionSpacing = 0.0
        static let cornerRadius = 0.0
    }
    
    private func bindViewModel() {
        viewModel?.didUpdateState = {[weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .error(let error):
                    self?.activityIndicator.stopAnimating()
                    self?.showAlert("Oops!", body: error)
                case .fetchingNextPaginatedData:
                    print("Pagination")
                case .loading:
                    self?.activityIndicator.startAnimating()
                case .none:
                    self?.activityIndicator.stopAnimating()
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel else {
            return UICollectionViewCell()
        }
        let character = viewModel.character(at: indexPath.row)
        return collectionView.dequeueConfiguredReusableCell(
            using: characterCellRegistration,
            for: indexPath,
            item: character
        )
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel?.loadMoreCharactersIfNeeded(currentIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let ch = viewModel?.character(at: indexPath.row) else {
            return
        }
        let vc = CharacterDetailViewController(character: ch)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIViewController {
    func showAlert(_ title : String!, body : String!, showCancel : Bool = false, completion: @escaping () -> () = {}) {
        let alertController = UIAlertController(title: title, message:
            body, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: { action in
            completion()
        }))
        if showCancel {
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default,handler: { action in
            }))
        }

        self.present(alertController, animated: true, completion: nil)
    }
}
