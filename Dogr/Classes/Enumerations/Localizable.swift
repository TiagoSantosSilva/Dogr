//
//  Localizable.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

enum Localizable {
    enum BreedList {
        enum NavigationBar {
            static let title = "Breeds"
        }

        enum TabBar {
            static let title = "Breeds"
        }
    }

    enum BreedPictures {
        enum NavigationBar {
            static let title = "Pictures"
        }

        enum TabBar {
            static let title = "Pictures"
        }
    }

    enum FavoritePictures {
        enum NavigationBar {
            static let title = "Favorites"
        }

        enum TabBar {
            static let title = "Favorites"
        }

        enum EmptyBar {
            static let title = "This is quiet, too quiet... 👀"
            static let message = "Set some pictures as your favorites so they show up on this gallery!"
        }
    }

    enum FavoritePicturesFilter {
        enum NavigationBar {
            static let title = "Filter"
            static let reset = "Reset"
            static let done = "Done"
        }
    }
}
