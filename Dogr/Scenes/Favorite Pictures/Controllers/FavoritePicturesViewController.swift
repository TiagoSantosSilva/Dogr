//
//  FavoritePicturesViewController.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Combine
import UIKit

protocol FavoritePicturesViewControllerDelegate: AnyObject {
    func viewController(_ viewController: FavoritePicturesViewController,
                        didTap filterButton: UIBarButtonItem,
                        with breeds: [FavoritePicturesFilterItemViewModel])
}

final class FavoritePicturesViewController: ViewController {

    // MARK: Properties

    weak var delegate: FavoritePicturesViewControllerDelegate?
    private let collectionViewController: FavoritePicturesCollectionViewController
    private let viewModel: FavoritePicturesViewModelable
    private var cancellables: Set<AnyCancellable> = .init()

    private lazy var emptyView = FavoritePicturesEmptyView()

    // MARK: Initialization

    init(viewModel: FavoritePicturesViewModelable) {
        self.collectionViewController = FavoritePicturesCollectionViewController()
        self.viewModel = viewModel
        super.init()

        setupNavigationBar()
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        setupContent()
        setupSubviews()
    }

    // MARK: Functions

    func applyFilter(with breeds: [FavoritePicturesFilterItemViewModel]) {
        viewModel.filter(with: breeds)
        setupRightBarButtonItem(isFilterButtonFilled: viewModel.isApplyingFilter)
    }

    // MARK: Setups

    private func setupNavigationBar() {
        title = Localizable.FavoritePictures.NavigationBar.title
    }

    private func setupSubviews() {
        setupRightBarButtonItem()
    }

    private func setupContent() {
        viewModel.groups.sink { [weak self] in
            if $0.isEmpty {
                guard self?.emptyView.superview == nil else { return }
                self?.collectionViewController.remove()
                self?.setupEmptyView()
            } else {
                guard self?.collectionViewController.parent == nil else { return }
                self?.emptyView.removeFromSuperview()
                self?.setupCollectionView()
            }
            self?.collectionViewController.update(with: $0)
        }.store(in: &cancellables)
    }

    private func setupEmptyView() {
        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupCollectionView() {
        add(collectionViewController)
    }

    private func setupRightBarButtonItem(isFilterButtonFilled: Bool = false) {
        let image = isFilterButtonFilled ? Images.filterFilled : Images.filterEmpty
        navigationItem.setRightBarButton(.init(image: image,
                                               style: .plain,
                                               target: self,
                                               action: #selector(filterButtonTapped)),
                                         animated: false)
    }

    // MARK: Selectors

    @objc
    private func filterButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.viewController(self, didTap: sender, with: viewModel.filterModeledBreeds)
    }
}

// MARK: - Constants

private extension FavoritePicturesViewController {
    enum Images {
        static let filterEmpty: UIImage = UIImage(systemName: "line.3.horizontal.decrease.circle")!
        static let filterFilled: UIImage = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")!
    }
}
