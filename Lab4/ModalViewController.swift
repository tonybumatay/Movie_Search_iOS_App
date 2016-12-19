//
//  ModalViewController.swift
//  Lab4
//
//  Created by Tony Bumatay on 10/19/16.
//  Copyright © 2016 Tony Bumatay. All rights reserved.
//

import Foundation
import UIKit

class ModalViewController: UIViewController{
    
    var favoriteMovieIDs = [String]()
    var favoriteMovieTitles = [String]()
    var tempFavorites = [String]()
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
    }
    
    @IBAction func deleteFavoritePressed(sender: UIButton) {
        
        //pull NSUserDefaults array of MovieIds
//        let tempFavs = NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovieIDs")
//        var favsByID = [String]()
//        if tempFavs != nil {
//            for id in tempFavs! {
//                tempFavorites.append(String(id))
//            }
//            var counter = 0
//            for id in favsByID {
//                if id == movieId{
//                    
//                }
//            }
//        }
//        NSUserDefaults.standardUserDefaults().setObject(tempFavorites, forKey: "favoriteMovieIDs")
        
        //update NSUserDefaults

        dismissViewControllerAnimated(true, completion: nil)

    }
    
    
}