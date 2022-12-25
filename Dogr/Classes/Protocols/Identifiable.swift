//
//  Identifiable.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

protocol Identifiable {}

extension Identifiable {
    public var name: String { return String(describing: self) }
    public static var name: String { return String(describing: self) }
}

extension Identifiable where Self: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
}
