//
//  Endpoint.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

protocol Endpoint {
    var host: String { get }
    var path: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
}
