//
//  NetworkError.swift
//  Dogr
//
//  Created by Tiago Silva on 25/12/2022.
//

enum NetworkError: Error {
    case noData
    case urlBuildFail
    case redirection
    case client
    case server
}
