//
//  CellDequeuable.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol CellDequeuable {}

extension CellDequeuable where Self: UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { fatalError(StringError.dequeueReusableCell) }
        return cell
    }

    func cellForItem<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = cellForItem(at: indexPath) as? T else { fatalError(StringError.dequeueReusableCell) }
        return cell
    }

    func cellFor<T: UICollectionViewCell>(row: Int) -> T {
        guard let cell = cellForItem(for: IndexPath(item: row, section: 0)) as? T else { fatalError(StringError.dequeueReusableCell) }
        return cell
    }
}
