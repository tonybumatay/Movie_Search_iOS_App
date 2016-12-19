//
//  MovieViewController.swift
//  Lab4
//
//  Created by Tony Bumatay on 10/18/16.
//  Copyright © 2016 Tony Bumatay. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var selectedMovieImage: UIImageView!
    @IBOutlet weak var selectedMovieTitle: UILabel!
    @IBOutlet weak var selectedMovieRating: UILabel!
    @IBOutlet weak var selectedMovieReleaseDate: UILabel!
    @IBOutlet weak var selectedMovieRunTime: UILabel!
    
   
    
    var movieImage = UIImage()
    var movieTitle = String()
    var movieRating = String()
    var movieRunTime = String()
    var movieReleaseDate = String()
    var movieId = String()
    //var movieIMDBRating = String()
    
    
    @IBAction func addToFavoritesPressed(sender: UIButton) {
        //pull NSUserDefaults array of MovieIds
        let temp = NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovieIDs")
        var tempFavorites = [String]()
        if temp != nil {
            for item in temp! {
                tempFavorites.append(String(item))
            }
            var exists = false
            for tempID in tempFavorites {
                if tempID == movieId {
                    exists = true
                }
            }
            if !exists {
                tempFavorites.append(movieId)
            }
            
        }
        else{
            tempFavorites.append(movieId)
        }
        NSUserDefaults.standardUserDefaults().setObject(tempFavorites, forKey: "favoriteMovieIDs")
        
        //update NSUserDefaults
    }
    
    override func viewDidLoad() {
        selectedMovieImage.image = movieImage
        selectedMovieTitle.text = movieTitle
        selectedMovieRating.text = movieRating
        selectedMovieReleaseDate.text = movieReleaseDate
        selectedMovieRunTime.text = movieRunTime
        //selectedMovieIMDBRating.text = movieIMDBRating

    }
    
        
}