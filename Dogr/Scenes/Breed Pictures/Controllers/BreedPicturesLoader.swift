//
//  BreedPicturesLoader.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol BreedPicturesLoadable: AnyObject {
    func cancelImageLoad(url: String)
    func loadImageList() async throws -> BreedPicturesModelResult
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void)
}

final class BreedPicturesLoader: BreedPicturesLoadable {

    // MARK: Properties

    private let breed: BreedListModelViewModel
    private let networkEngine: NetworkEnginable

    // MARK: Initialization

    init(dependencies: DependencyContainable, breed: BreedListModelViewModel) {
        self.breed = breed
        self.networkEngine = dependencies.networkEngine
    }

    // MARK: Functions

    func cancelImageLoad(url: String) {
        networkEngine.cancel(url: url)
    }

    func loadImageList() async throws -> BreedPicturesModelResult {
        try await networkEngine.request(endpoint: BreedEndpoint.pictures(breed: breed.name)) as BreedPicturesModelResult
    }

    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        networkEngine.request(url: url) { result in
            switch result {
            case let .success(data):
                guard let image = UIImage(data: data) else { return }

                image.prepareForDisplay { preparedImage in
                    completion(preparedImage)
                }
            case .failure:
                return
            }
        }
    }
}
