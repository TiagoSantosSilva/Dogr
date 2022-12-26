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

    func changeFavoriteStatus(of viewModel: BreedPictureModelViewModel)
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
    private let breed: BreedListModelViewModel
    private let favoritesRepository: FavoritesRepositoriable
    private let loader: BreedPicturesLoadable

    // MARK: Initialization

    init(breed: BreedListModelViewModel, favoritesRepository: FavoritesRepositoriable, loader: BreedPicturesLoadable) {
        self.title = "\(breed.displayName) \(Localizable.BreedPictures.navigationBarTitle)"
        self.favoritesRepository = favoritesRepository
        self.loader = loader
        self.breed = breed
        loadImageList()
    }

    // MARK: Functions

    func changeFavoriteStatus(of viewModel: BreedPictureModelViewModel) {
        viewModel.isFavorite.toggle()
        if viewModel.isFavorite {
            favoritesRepository.add(BreedPictureModel(url: viewModel.url, breed: viewModel.breed, image: viewModel.image))
        } else {
            favoritesRepository.remove(url: viewModel.url, for: viewModel.breed)
        }
    }

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
                let models = result.message.map { imageURL in
                    let isFavorite = favoritesRepository.isImageFavorite(url: imageURL, for: breed.name)
                    return BreedPictureModelViewModel(url: imageURL, breed: breed.name, isFavorite: isFavorite)
                }
                self.images.send(models)
            } catch {
                self.images.send(completion: .failure(BreedPicturesViewModelError.failedImageListFetch))
            }
        }
    }
}
