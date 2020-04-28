//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Luiz F. A. Pio on 22/04/20.
//  Copyright © 2020 Luiz Felipe Albernaz Pio. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MovieListPresenterProtocol?
    
    private var viewModels: [MovieViewModel] = []
    private var cellIdentifier: String = "MovieListTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        presenter?.fetchMovies()
    }
}

extension MovieListViewController: MovieListPresenterOutputDelegate {
    func didFetchMoviesSuccessfully(viewModels: [MovieViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    func didFetchMovies(withErrorMessage errorMessage: String) {
    }    
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            }
            return cell
        }()
        
        cell.textLabel?.text = viewModels[indexPath.row].title
        
        return cell
    }
}
