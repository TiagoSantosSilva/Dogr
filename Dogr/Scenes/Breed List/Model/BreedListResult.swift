//
//  BreedListResult.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

import Foundation

enum NetworkResultStatus: Decodable {
    case success
    case error
}

struct BreedListResult: Decodable {
    let message: [String: [String]]
}
