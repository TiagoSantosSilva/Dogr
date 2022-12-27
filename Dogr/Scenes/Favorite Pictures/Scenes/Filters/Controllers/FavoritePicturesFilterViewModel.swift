//
//  FavoritePicturesFilterViewModel.swift
//  Dogr
//
//  Created by Tiago Silva on 27/12/2022.
//

import Foundation

protocol FavoritePicturesFilterViewModelable: AnyObject {
    var items: [FavoritePicturesFilterItemViewModel] { get }

    func itemTapped(at indexPath: IndexPath)
    func resetFilter()
}

final class FavoriteFilterPicturesViewModel: FavoritePicturesFilterViewModelable {

    // MARK: Properties

    let items: [FavoritePicturesFilterItemViewModel]

    // MARK: Iniitalization

    init(items: [FavoritePicturesFilterItemViewModel]) {
        self.items = items
    }

    // MARK: Functions

    func itemTapped(at indexPath: IndexPath) {
        let itemToSelect = items[indexPath.row]

        guard !itemToSelect.isSelected else {
            itemToSelect.isSelected = false
            return
        }

        let itemToDeselect = items.first { $0.isSelected }
        itemToDeselect?.isSelected = false
        itemToSelect.isSelected = true
    }

    func resetFilter() {
        items.first { $0.isSelected }?.isSelected = false
    }
}
