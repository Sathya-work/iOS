//
//  MovieCollectionViewCell.swift
//  CollectionviewMovies
//
//  Created by Sathyanarayana on 4/10/25.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func assignMovie(movie: Movie) {
        imageView.image = movie.image
    }
}
