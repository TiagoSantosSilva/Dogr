//
//  BreedListViewModel.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol BreedListViewModelable: AnyObject {
    var breeds: [BreedListModelViewModel] { get }
    func loadBreeds(completion: @escaping (ViewModelLoadResult) -> Void)
}

enum ViewModelLoadResult {
    case success
    case error
}

final class BreedListViewModel: BreedListViewModelable {

    // MARK: Properties

    private(set) var breeds: [BreedListModelViewModel] = []
    private let loader: BreedListLoadable

    // MARK: Initialization

    init(loader: BreedListLoadable) {
        self.loader = loader
    }

    // MARK: Functions

    func loadBreeds(completion: @escaping (ViewModelLoadResult) -> Void) {
        Task {
            do {
                let result = try await loader.loadBreeds()
                self.breeds = result.message.map {
                    .init(name: $0.key, subBreeds: $0.value)
                }.sorted {
                    $0.name < $1.name
                }

                completion(.success)
            } catch {
                completion(.error)
            }
        }
    }
}
