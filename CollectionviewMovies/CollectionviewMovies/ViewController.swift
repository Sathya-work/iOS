//
//  ViewController.swift
//  CollectionviewMovies
//
//  Created by Sathyanarayana on 4/10/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewOL.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        cell.assignMovie(movie: movies[indexPath.row] )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        titleOL.text = "Movie Title: \(movies[indexPath.row].title)"
        yearOL.text = "Released Year: \(movies[indexPath.row].releasedYear)"
        ratingOL.text = "Rating: \(movies[indexPath.row].movieRating)"
        revenueOL.text = "Movie Revenue: \(movies[indexPath.row].boxOffice)"
    }
    
    
    @IBOutlet weak var titleOL: UILabel!
    
    @IBOutlet weak var yearOL: UILabel!
    
    @IBOutlet weak var ratingOL: UILabel!
    
    @IBOutlet weak var revenueOL: UILabel!
    
    @IBOutlet weak var collectionViewOL: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionViewOL.delegate = self
        collectionViewOL.dataSource = self
    }


}

