//
//  DependencyContainer.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol DependencyContainable: AnyObject {
    var networkEngine: NetworkEnginable { get }
}

final class DependencyContainer: DependencyContainable {

    // MARK: Dependencies

    let networkEngine: NetworkEnginable

    // MARK: Initialization

    init() {
        let networkBuilder = NetworkRequestBuilder()
        let networkParser = NetworkResponseParser()
        self.networkEngine = NetworkEngine(builder: networkBuilder, parser: networkParser)
    }
}
