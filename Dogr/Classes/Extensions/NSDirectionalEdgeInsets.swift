//
//  NSDirectionalEdgeInsets.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

extension NSDirectionalEdgeInsets {
    init(padding: CGFloat) {
        self.init(top: padding,
                  leading: padding,
                  bottom: padding,
                  trailing: padding)
    }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical,
                  leading: horizontal,
                  bottom: vertical,
                  trailing: horizontal)
    }
}
