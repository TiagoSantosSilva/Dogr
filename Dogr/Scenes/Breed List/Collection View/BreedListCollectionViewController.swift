//
//  BreedListCollectionViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol BreedListCollectionViewControllerDelegate: AnyObject {
    func collectionViewController(_ collectionViewController: BreedListCollectionViewController, didSelectItemAt indexPath: IndexPath)
}

extension NSDirectionalEdgeInsets {
    init(padding: CGFloat) {
        self.init(top: padding,
                  leading: padding,
                  bottom: padding,
                  trailing: padding)
    }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical,
                  leading: horizontal,
                  bottom: vertical,
                  trailing: horizontal)
    }
}

final class BreedListCollectionViewController: CollectionViewController {

    // MARK: Enum

    private enum Section {
        case main
    }

    // MARK: Typealiases

    private typealias CellRegistration = UICollectionView.CellRegistration<BreedListCell, BreedListModelViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, BreedListModelViewModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, BreedListModelViewModel>

    // MARK: Properties

    weak var delegate: BreedListCollectionViewControllerDelegate?

    private let dataSource: DataSource

    // MARK: Initialization

    override init() {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(horizontal: 16, vertical: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        let layoutSection = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: layoutSection)

        let collectionView = CollectionView(frame: .zero, collectionViewLayout: layout)
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: Self.cellProvider)
        super.init(collectionViewLayout: layout)
        self.collectionView = collectionView
    }

    // MARK: Functions

    @MainActor func update(with breeds: [BreedListModelViewModel]) {
        Task {
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(breeds)
            collectionView.layer.add(CATransition.fade, forKey: nil)
            await dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    // MARK: Setups

    private static var cellProvider: ((UICollectionView, IndexPath, BreedListModelViewModel) -> UICollectionViewCell?) {
        let cellRegistration = CellRegistration { cell, _, cellViewModel in
            cell.configure(with: cellViewModel)
        }

        return { collectionView, indexPath, cellViewModel in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: cellViewModel)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension BreedListCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewController(self, didSelectItemAt: indexPath)
    }
}
