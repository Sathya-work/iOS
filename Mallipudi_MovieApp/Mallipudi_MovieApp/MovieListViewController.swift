//
//  MovieListViewController.swift
//  Mallipudi_MovieApp
//
//  Created by Sathyanarayana on 4/24/25.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    var movies: [MovieList] = []
        var genreTitle: String = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            title = genreTitle
            movieListTableView.delegate = self
            movieListTableView.dataSource = self
            movieListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "movieCell")
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
            let movie = movies[indexPath.row]
            cell.textLabel?.text = movie.movieName
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let selectedMovie = movies[indexPath.row]
            performSegue(withIdentifier: "movieInfoSegue", sender: selectedMovie)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieInfoSegue" {
            let destination = segue.destination as! MovieInfoViewController
            if let selectedMovie = sender as? MovieList {
                destination.movie = selectedMovie
            }
        }
    }
    }
