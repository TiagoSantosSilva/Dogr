//
//  Coordinator.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

public typealias Coordinator = CoordinatorClass & CoordinatorStartable

public protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidEnd(_ coordinator: CoordinatorClass)
}

public protocol CoordinatorStartable {
    func start()
}

extension CoordinatorStartable {
    func start() { }
}

public protocol CoordinatorEndable {
    func end()
}

open class CoordinatorClass: NSObject, CoordinatorEndable, CoordinatorDelegate {

    // MARK: - Properties

    public weak var coordinatorDelegate: CoordinatorDelegate?
    public lazy var coordinators: [CoordinatorClass] = []

    // MARK: - Functions

    @discardableResult
    public func initiate(coordinator: Coordinator) -> Coordinator {
        coordinator.coordinatorDelegate = self
        coordinators.append(coordinator)
        coordinator.start()
        return coordinator
    }

    public func end() {
        coordinatorDelegate?.coordinatorDidEnd(self)
    }

    // MARK: - Coordinator Delegate

    public func coordinatorDidEnd(_ coordinator: CoordinatorClass) {
        coordinators = coordinators.filter { $0 !== coordinator }
    }
}
