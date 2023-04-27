//
//  Book.swift
//  OpenLibrary
//
//  Created by Максим  on 27.04.23.
//

import Foundation

struct BooksID: Codable {
    let isbn9780747591269: BooksStructure
    let isbn9781435238138: BooksStructure
    let isbn9780747542988: BooksStructure
    let isbn9780545029360: BooksStructure

    enum CodingKeys: String, CodingKey {
        case isbn9780747591269 = "ISBN:9780747591269"
        case isbn9781435238138 = "ISBN:9781435238138"
        case isbn9780747542988 = "ISBN:9780747542988"
        case isbn9780545029360 = "ISBN:9780545029360"
    }
}

struct BooksStructure: Codable {
    let thumbnail_url: String
    let bib_key: String
    let details: Details
}

struct Details: Codable {
    let title: String
    let description: String?
    let publish_date: String
}


