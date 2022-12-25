//
//  BreedPicturesViewModel.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Combine
import UIKit

protocol BreedPicturesViewModelable: AnyObject {
    var title: String { get }
    var images: CurrentValueSubject<[BreedPictureModelViewModel], Error> { get }

    func cancel(indexPath: IndexPath)
    func loadImage(for indexPath: IndexPath, completion: @escaping (Result<UIImage?, BreedPicturesViewModelError>) -> Void)
}

enum BreedPicturesViewModelError: Error {
    case failedImageFetch
    case failedImageListFetch
}

final class BreedPicturesViewModel: BreedPicturesViewModelable {

    // MARK: Properties

    let title: String
    private(set) var images: CurrentValueSubject<[BreedPictureModelViewModel], Error> = .init([])
    private let loader: BreedPicturesLoadable

    // MARK: Initialization

    init(breed: BreedListModelViewModel, loader: BreedPicturesLoadable) {
        self.title = "\(breed.displayName) \(Localizable.BreedPictures.navigationBarTitle)"
        self.loader = loader
        loadImageList()
    }

    // MARK: Functions

    func cancel(indexPath: IndexPath) {
        let model = images.value[indexPath.row]
        guard model.image == nil else { return }
        loader.cancelImageLoad(url: model.url)
    }

    func loadImage(for indexPath: IndexPath, completion: @escaping (Result<UIImage?, BreedPicturesViewModelError>) -> Void) {
        let model = images.value[indexPath.row]
        guard model.image == nil else {
            completion(.success(model.image))
            return
        }
        loader.loadImage(url: model.url) { [weak self] image in
            self?.images.value[indexPath.row].image = image
            completion(image != nil ? .success(image) : .failure(.failedImageFetch))
        }
    }

    private func loadImageList() {
        Task {
            do {
                let result = try await loader.loadImageList()
                let models = result.message.map { BreedPictureModelViewModel(url: $0) }
                self.images.send(models)
            } catch {
                self.images.send(completion: .failure(BreedPicturesViewModelError.failedImageListFetch))
            }
        }
    }
}
