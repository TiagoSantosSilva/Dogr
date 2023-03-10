//
//  CellRegistable.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol CellRegistable {}

extension CellRegistable where Self: UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.name, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.identifier)
    }

    func registerCellClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach(register)
    }
}
