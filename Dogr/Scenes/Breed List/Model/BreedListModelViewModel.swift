//
//  BreedListModelViewModel.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

typealias BreedList = [String: [String]]

struct BreedListModelViewModel: Hashable {

    // MARK: Properties

    let uuid: UUID = .init()
    let name: String
    let subBreeds: [String]

    // MARK: Initialization

    init(name: String, subBreeds: [String]) {
        self.name = name.capitalized
        self.subBreeds = subBreeds
    }
    
    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    // MARK: Equatable

    static func == (lhs: BreedListModelViewModel, rhs: BreedListModelViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
