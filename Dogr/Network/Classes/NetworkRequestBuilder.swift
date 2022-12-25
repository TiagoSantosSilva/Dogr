//
//  NetworkRequestBuilder.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol NetworkRequestBuildable {
    func buildRequest(for endpoint: Endpoint) throws -> URLRequest
}

struct NetworkRequestBuilder: NetworkRequestBuildable {

    // MARK: - Functions

    func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = URLScheme.https.rawValue
        components.host = endpoint.host
        components.path = endpoint.path.appending(endpoint.endpoint)
        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw NetworkError.urlBuildFail
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        return request
    }
}
