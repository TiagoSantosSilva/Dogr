//
//  NetworkEngine.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol NetworkEnginable: AnyObject {
    func cancel(url: String)
    func request(url: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

final class NetworkEngine: NetworkEnginable {

    // MARK: - Properties

    private let builder: NetworkRequestBuildable
    private let parser: NetworkResponseParseable
    private var tasks: [String: Task<(), Never>] = [:]

    // MARK: - Initialization

    init(builder: NetworkRequestBuildable, parser: NetworkResponseParseable) {
        self.builder = builder
        self.parser = parser
    }

    // MARK: - Functions

    func cancel(url: String) {
        tasks[url]?.cancel()
    }

    func request(url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = Task {
            do {
                let request = try self.builder.buildRequest(for: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                completion(.success(data))
            } catch {
                completion(.failure(.noData))
            }
        }
        tasks[url] = task
    }

    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let (data, response) = try await request(endpoint: endpoint)
        return try parser.parse(response: response, data: data)
    }

    private func request(endpoint: Endpoint) async throws -> (Data, URLResponse) {
        let request = try builder.buildRequest(for: endpoint)
        return try await URLSession.shared.data(for: request)
    }
}
