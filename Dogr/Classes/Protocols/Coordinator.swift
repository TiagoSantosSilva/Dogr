//
//  Coordinator.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

typealias Coordinator = CoordinatorClass & CoordinatorStartable

protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidEnd(_ coordinator: CoordinatorClass)
}

protocol CoordinatorStartable {
    func start()
}

extension CoordinatorStartable {
    func start() { }
}

protocol CoordinatorEndable {
    func end()
}

class CoordinatorClass: NSObject, CoordinatorEndable, CoordinatorDelegate {

    // MARK: - Properties

    weak var coordinatorDelegate: CoordinatorDelegate?
    lazy var coordinators: [CoordinatorClass] = []

    // MARK: - Functions

    @discardableResult
    func initiate(coordinator: Coordinator) -> Coordinator {
        coordinator.coordinatorDelegate = self
        coordinators.append(coordinator)
        coordinator.start()
        return coordinator
    }

    func end() {
        coordinatorDelegate?.coordinatorDidEnd(self)
    }

    // MARK: - Coordinator Delegate

    func coordinatorDidEnd(_ coordinator: CoordinatorClass) {
        coordinators = coordinators.filter { $0 !== coordinator }
    }
}
