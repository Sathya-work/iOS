//
//  ViewController.swift
//  Mallipudi_MovieApp
//
//  Created by Sathyanarayana on 4/24/25.
//

import UIKit

class MallipudiMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "genreCell")
        title = "Movie Genres"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedGenre = genres[indexPath.row]
        
        if let moviesForGenre = moviesCollection.first(where: { $0.genre == selectedGenre }) {
            
            performSegue(withIdentifier: "listsSegue", sender: moviesForGenre)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listsSegue" {
            let destination = segue.destination as! MovieListViewController
            if let moviesForGenre = sender as? Movies {
                destination.movies = moviesForGenre.list_Array
                destination.genreTitle = moviesForGenre.genre
            }
        }
    }
}
