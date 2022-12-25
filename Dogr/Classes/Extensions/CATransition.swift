//
//  CATransition.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import UIKit

extension CATransition {
    static let fade: CATransition = {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.duration = 0.2
        return transition
    }()
}
