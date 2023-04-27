//
//  BookTableViewCell.swift
//  OpenLibrary
//
//  Created by Максим  on 27.04.23.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    func configure(with book: BooksStructure) {
        titleLabel.text = book.details.title
        yearLabel.text = book.details.publish_date
        
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
    }
}
