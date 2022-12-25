//
//  NetworkResponseParser.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol NetworkResponseParseable: AnyObject {
    func parse(response: URLResponse, data: Data) throws -> Data
    func parse<T: Decodable>(response: URLResponse, data: Data) throws -> T
}

final class NetworkResponseParser: NetworkResponseParseable {

    // MARK: - Properties

    private lazy var decoder = JSONDecoder()

    // MARK: - Initialization

    init() { }

    // MARK: - Internal Functions

    func parse(response: URLResponse, data: Data) throws -> Data {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.urlBuildFail
        }

        guard isResponseSuccessful(response) else { throw NetworkError.noData }
        return data
    }

    func parse<T: Decodable>(response: URLResponse, data: Data) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.urlBuildFail
        }

        guard isResponseSuccessful(response) else { throw NetworkError.noData }
        return try decoder.decode(T.self, from: data)
    }

    // MARK: - Private Functions

    private func isResponseSuccessful(_ response: HTTPURLResponse) -> Bool {
        ResponseCodes.successful.contains(response.statusCode)
    }
}

private extension NetworkResponseParser {
    enum ResponseCodes {
        static let successful: ClosedRange<Int> = 200...299
        static let redirection: ClosedRange<Int> = 300...399
        static let clientError: ClosedRange<Int> = 400...499
        static let serverError: ClosedRange<Int> = 500...599
    }
}
