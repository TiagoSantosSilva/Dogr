//
//  BreedEndpoint.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

enum BreedEndpoint: Endpoint {
    case list
    case pictures(breed: String)
}

extension BreedEndpoint {
    var host: String {
        "dog.ceo"
    }

    var path: String {
        "/api/"
    }

    var endpoint: String {
        switch self {
        case .list:
            return "list/all"
        case let .pictures(breed):
            return "breed/\(breed)/images"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem]? {
        nil
    }
}
