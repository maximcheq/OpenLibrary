//
//  ViewController.swift
//  OpenLibrary
//
//  Created by Максим  on 27.04.23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var books = [BooksStructure]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        APICaller.shared.getBookInfo { result in
            switch result {
            case .success(let result):
                self.books = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        let book = books[indexPath.row]
        
        cell.configure(with: book)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = books[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else { return }
        
        vc.selectedBook = book
        
        present(vc, animated: true)
    }
}

