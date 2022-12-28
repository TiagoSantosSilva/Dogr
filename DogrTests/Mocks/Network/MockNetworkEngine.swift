//
//  MockNetworkEngine.swift
//  DogrTests
//
//  Created by Tiago Silva on 27/12/2022.
//

import Foundation
@testable import Dogr

final class MockNetworkEngine: NetworkEnginable {

    // MARK: - Properties

    var cancelHandler: (() -> Void)?
    var stringRequestHandler: ((String) -> Data)?
    var endpointRequestHandler: ((Endpoint) -> Decodable)?

    // MARK: - Functions

    func cancel(url: String) {
        guard let cancelHandler = cancelHandler else {
            fatalError()
        }

        cancelHandler()
    }

    func request(url: String, completion: @escaping (Result<Data, Dogr.NetworkError>) -> Void) {
        guard let handler = stringRequestHandler else {
            fatalError()
        }

        completion(.success(handler(url)))
    }

    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let handler = endpointRequestHandler, let decodable = handler(endpoint) as? T else {
            fatalError()
        }

        return decodable
    }
}
