//
//  NetworkEngine.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol NetworkEnginable: AnyObject {
    func request(endpoint: Endpoint) async throws -> Data
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

final class NetworkEngine: NetworkEnginable {

    // MARK: - Properties

    private let builder: NetworkRequestBuildable
    private let parser: NetworkResponseParseable

    // MARK: - Initialization

    init(builder: NetworkRequestBuildable, parser: NetworkResponseParseable) {
        self.builder = builder
        self.parser = parser
    }

    // MARK: - Functions

    func request(endpoint: Endpoint) async throws -> Data {
        let (data, response) = try await request(endpoint: endpoint)
        return try parser.parse(response: response, data: data)
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
