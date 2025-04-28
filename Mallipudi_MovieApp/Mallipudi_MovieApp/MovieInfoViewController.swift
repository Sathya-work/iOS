//
//  MovieInfoViewController.swift
//  Mallipudi_MovieApp
//
//  Created by Sathyanarayana on 4/24/25.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    @IBOutlet weak var movieImageViewOutlet: UIImageView!
    
    @IBOutlet weak var movieInfoOutlet: UITextView!
    
    var movie: MovieList?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            title = movie.movieName
            movieImageViewOutlet.image = UIImage(named: movie.movieImage)
            
            movieImageViewOutlet.alpha = 0
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
                self.movieImageViewOutlet.alpha = 1
            })
        }
        movieInfoOutlet.text! = ""
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieInfoSegue" {
            if let destination = segue.destination as? MovieInfoViewController,
               let selectedMovie = sender as? MovieList {
                destination.movie = selectedMovie
            }
        }
    }
        
    @IBAction func showInfoAction(_ sender: Any) {
        if let movie = movie {
            movieInfoOutlet.text = movie.movieInfo
        }
    }
}
