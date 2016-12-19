//
//  FirstViewController.swift
//  Lab4
//
//  Created by Tony Bumatay on 10/18/16.
//  Copyright © 2016 Tony Bumatay. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    var movies = [Movie]()
    var imageCache = [UIImage]()
    
    @IBOutlet weak var movieView: UICollectionView!
    @IBOutlet weak var movieSearch: UISearchBar!
    
    @IBOutlet weak var loadingImg: UIActivityIndicatorView!
    
    
    
    
    
    
    override func viewDidLoad() {
        self.movieView.dataSource = self
        self.movieSearch.delegate = self
        self.movieView.delegate = self
        self.movieView.backgroundColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section:Int) ->Int {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = movieView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CellData
        cell.backgroundColor = UIColor.clearColor()
        cell.title = movies[indexPath.item].title
        cell.movImage = imageCache[indexPath.item]
        cell.id = movies[indexPath.item].id
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didselectItemAtIndexPath indexPath: NSIndexPath){

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let movieDetail = segue.destinationViewController as! MovieViewController
        let cell = sender as! CellData
        movieDetail.movieImage = cell.movImage
        movieDetail.movieId = cell.id
        let urlComponents = NSURLComponents(string: "https://www.omdbapi.com/?i=\(movieDetail.movieId)&plot=short&r=json")!
        let url = urlComponents.URL!
        //print("this is the url: ")
        //print(url)
        if let data = NSData(contentsOfURL: url){
            let json = JSON(data: data)
            //print(json)
            movieDetail.movieRating = json["Rated"].stringValue
            //movieDetail.movieRating = json["imdbRating"].stringValue
            movieDetail.movieReleaseDate = json["Released"].stringValue
            movieDetail.movieTitle = json["Title"].stringValue
            movieDetail.movieRunTime = json["Runtime"].stringValue
        }
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        movies.removeAll()
        imageCache.removeAll()
        self.loadingImg.hidesWhenStopped = true
        self.loadingImg.startAnimating()
//        print("it should start spinnig now")

        let urlComponents = NSURLComponents(string: "https://www.omdbapi.com/")!
        urlComponents.query = "s=\(searchText)"
        //urlComponents.query = "s=\(searchText)&page=3"
        let url = urlComponents.URL!

        print(url)
        if let data = NSData(contentsOfURL: url){
            let json = JSON(data: data)
            let search = json["Search"].arrayValue
            //print("There are this many search results: " + String(search.count))
            
            for item in search{
                //print(json)
                let temp = Movie()
                temp.title = item["Title"].stringValue
                temp.releaseDate = item["Released"].stringValue
                temp.poster = item["Poster"].stringValue
                temp.id = item["imdbID"].stringValue
                temp.runTime = item["Runtime"].stringValue

                let urlPic = NSURL(string: temp.poster)
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                    //self.loadingImg.startAnimating()
                    //print("it should start spinnig now")
                    let imageData = NSData(contentsOfURL: urlPic!)
                    dispatch_async(dispatch_get_main_queue()){
                        if imageData == nil{
                            let notFoundImage = UIImage(named: "image-not-found")
                            self.imageCache.append(notFoundImage!)
                        }
                        else{
                            let image = UIImage(data: imageData!)
                            self.imageCache.append(image!)
                        }
                        self.movies.append(temp)
                        self.movieView.reloadData()
                    }
                }
                self.loadingImg.stopAnimating()
            }
            
        }
        
        let urlComponents2 = NSURLComponents(string: "https://www.omdbapi.com/")!
        urlComponents2.query = "s=\(searchText)&page=2"
        let url2 = urlComponents2.URL!
        print(url2)

        
        if let data = NSData(contentsOfURL: url2){
            let json = JSON(data: data)
            let search = json["Search"].arrayValue
            //print("There are this many search results: " + String(search.count))
            
            for item in search{
                //print(json)
                let temp = Movie()
                temp.title = item["Title"].stringValue
                temp.releaseDate = item["Released"].stringValue
                temp.poster = item["Poster"].stringValue
                temp.id = item["imdbID"].stringValue
                temp.runTime = item["Runtime"].stringValue
                
                let urlPic = NSURL(string: temp.poster)
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                    //self.loadingImg.startAnimating()
                    let imageData = NSData(contentsOfURL: urlPic!)
                    dispatch_async(dispatch_get_main_queue()){
                        if imageData == nil{
                            let notFoundImage = UIImage(named: "image-not-found")
                            self.imageCache.append(notFoundImage!)
                        }
                        else{
                            let image = UIImage(data: imageData!)
                            self.imageCache.append(image!)
                        }
                        self.movies.append(temp)
                        self.movieView.reloadData()
                    }

                }

            }
            
        }
    }
    
}

