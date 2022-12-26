//
//  FavoritePicturesCollectionViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

final class FavoritePicturesCollectionViewController: CollectionViewController {

    // MARK: Typealiases

    private typealias CellRegistration = UICollectionView.CellRegistration<FavoritePicturesCell, BreedPictureModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<BreedPictureGroupModel, BreedPictureModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<BreedPictureGroupModel, BreedPictureModel>

    // MARK: Properties

    private var dataSource: DataSource

    // MARK: Initialization

    override init() {
        let layout = FavoritePicturesCollectionViewLayout()
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: layout)
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: Self.cellProvider)
        super.init(collectionViewLayout: layout)
        self.collectionView = collectionView
        setup()
    }

    // MARK: Functions

    @MainActor func update(with groups: [BreedPictureGroupModel]) {
        Task {
            var snapshot = Snapshot()
            snapshot.appendSections(groups)
            groups.enumerated().forEach {
                snapshot.appendItems($0.element.pictures, toSection: $0.element)
            }
            collectionView.layer.add(CATransition.fade, forKey: nil)
            await dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    // MARK: Setups

    private func setup() {
        let kind = FavoritePicturesCollectionViewLayout.ElementKinds.header
        let headerRegistration = UICollectionView.SupplementaryRegistration<FavoritePictureHeader>(elementKind: kind) { [unowned self] header, _, indexPath in
            let group = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            header.configure(with: group)
        }

        self.dataSource.supplementaryViewProvider = { [unowned self] _, _, index in
            self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
    }

    // MARK: Cell Provider

    private static var cellProvider: ((UICollectionView, IndexPath, BreedPictureModel) -> UICollectionViewCell?) {
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
