//
//  BreedListResultStub.swift
//  DogrTests
//
//  Created by Tiago Silva on 28/12/2022.
//

import Foundation
@testable import Dogr

enum BreedListResultStub {
    static let orderedBreedList: [String] = ["Affenpinscher",
                                             "African",
                                             "Basenji",
                                             "Chihuahua",
                                             "Finnish",
                                             "Labrador",
                                             "Mix",
                                             "Otterhound",
                                             "Segugio"]
    static let unorderedBreedList: [String] = ["Affenpinscher",
                                               "African",
                                               "Basenji",
                                               "Mix",
                                               "Otterhound",
                                               "Labrador",
                                               "Finnish",
                                               "Chihuahua",
                                               "Segugio"]
}

extension BreedListResult {
    static let empty: BreedListResult = .init(message: [:])
    static let value: BreedListResult = .init(message: Dictionary(uniqueKeysWithValues: BreedListResultStub.unorderedBreedList.map { ($0, []) } ))
}
