//
//  UIView.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

extension UIView {
    func add(subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func round() {
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
