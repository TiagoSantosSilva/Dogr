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

final class BreedListCollectionViewController: CollectionViewController {

    // MARK: Enum

    enum Section {
        case main
    }

    // MARK: Typealiases

    private typealias CellRegistration = UICollectionView.CellRegistration<BreedListCell, BreedListModelViewModel>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, BreedListModelViewModel>

    // MARK: Properties

    weak var delegate: BreedListCollectionViewControllerDelegate?

    private let dataSource: DataSource

    // MARK: Initialization

    override init() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: layout)
        self.dataSource = DataSource(collectionView: collectionView, cellProvider: Self.cellProvider)
        super.init(collectionViewLayout: layout)
        self.collectionView = collectionView
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
