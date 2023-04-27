//
//  Rate.swift
//  OpenLibrary
//
//  Created by Максим  on 27.04.23.
//

import Foundation

struct Data: Codable {
    let docs: [Doc]?
}

struct Doc: Codable {
    let ratingsAverage: Double?

    enum CodingKeys: String, CodingKey {
        case ratingsAverage = "ratings_average"
    }
}
