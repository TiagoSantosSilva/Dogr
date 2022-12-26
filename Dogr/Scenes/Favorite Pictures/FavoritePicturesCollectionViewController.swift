//
//  FavoritePicturesCollectionViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 26/12/2022.
//

import UIKit

final class FavoritePicturesCollectionViewController: CollectionViewController {

    // MARK: Enumerations

    private enum Section {
        case main
    }

    // MARK: Typealiases

    private typealias CellRegistration = UICollectionView.CellRegistration<FavoritePicturesCell, BreedPictureModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, BreedPictureModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, BreedPictureModel>

    // MARK: Properties

    private var dataSource: DataSource

    // MARK: Initialization

    override init() {
        let layout = BreedPicturesCollectionViewLayout()
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: layout)
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: Self.cellProvider)
        super.init(collectionViewLayout: layout)
        self.collectionView = collectionView
    }

    // MARK: Functions

    @MainActor func update(with images: [BreedPictureModel]) {
        Task {
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(images)
            collectionView.layer.add(CATransition.fade, forKey: nil)
            await dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    // MARK: Setups

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
