//
//  DetailedViewController.swift
//  OpenLibrary
//
//  Created by Максим  on 27.04.23.
//

import UIKit

class DetailedViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    var selectedBook: BooksStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedBook {
            configure(with: selectedBook)
        }
    }
    
    func configure(with book: BooksStructure) {
        titleLabel.text = "Title: \(book.details.title)"
        yearLabel.text = "Year of publish: \(book.details.publish_date)"
        descriptionLabel.text = "Description: \(book.details.description ?? "No description")" 
        
        if let url = URL(string: book.thumbnail_url) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.coverImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
        let shortKey = book.bib_key.replacing("ISBN:", with: "")
        
        APICaller.shared.getRateInfo(with: shortKey) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.ratingLabel.text = "Rating: \(result?[0].ratingsAverage ?? 0)"
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
