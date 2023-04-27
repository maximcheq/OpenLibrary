//
//  APICaller.swift
//  OpenLibrary
//
//  Created by Максим  on 27.04.23.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    func getBookInfo(completion: @escaping (Result<[BooksStructure], Error>) -> Void) {
        guard let url = URL(string: "https://openlibrary.org/api/books?&bibkeys=ISBN:9780747591269,ISBN:9781435238138,ISBN:9781338299205,ISBN:9780747542988,ISBN:9780545029360&jscmd=details&format=json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(BooksID.self, from: data)
                    completion(.success([result.isbn9780747591269,
                                         result.isbn9781435238138,
                                         result.isbn9780747542988,
                                         result.isbn9780545029360,
                                        ]))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getRateInfo(with id: String, completion: @escaping (Result<[Doc]?, Error>) -> Void) {
        guard let url = URL(string: "https://openlibrary.org/search.json?q=\(id)&fields=ratings_average") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Data.self, from: data)
                    completion(.success(result.docs))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
