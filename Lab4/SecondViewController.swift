//
//  SecondViewController.swift
//  Lab4
//
//  Created by Tony Bumatay on 10/18/16.
//  Copyright © 2016 Tony Bumatay. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var middleImage: UIImageView!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    //Pull NSUserDefaults and load ids
    //var favoriteMovieIDs = [String()]//array of imdb id
    var theData: [Info] = []
    var theImageCache: [UIImage] = []
    var tableView: UITableView!
    var favoriteMovieIDs = [String]()
    var favoriteMovieTitles = [String]()
    var numRows = Int()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        let appDomain = NSBundle.mainBundle().bundleIdentifier!
//        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
    }
    
        // Do any additional setup after loading the view, typically from a nib.
    
    func setupTableView() {
        
        tableView = UITableView(frame: view.frame.offsetBy(dx:0, dy: 40))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
    }
    
    func fetchDataForTableView() {
        favoriteMovieTitles.removeAll()
        var favoriteMovieIDs = [String]()
        let tempFavs = NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovieIDs")
        if tempFavs != nil {
            for tempMovieID in tempFavs! {
                favoriteMovieIDs.append(String(tempMovieID))
            }
        }
        
        for id in favoriteMovieIDs {
            let urlComponents = NSURLComponents(string: "https://www.omdbapi.com/?i=\(id)&plot=short&r=json")!
            let url = urlComponents.URL!
            if let data = NSData(contentsOfURL: url){
                let json = JSON(data: data)
                
                //                Movie.rating = json["Rated"].stringValue
                //                Movie.title = json["Title"].stringValue
                //                Movie.runTime = json["Runtime"].stringValue
                
                favoriteMovieTitles.append(json["Title"].stringValue)
            }
        }
        print(favoriteMovieTitles)

        
    }

    
    
//    private func getJSON(url: String) -> JSON {
//        
//        if let nsurl = NSURL(string: url){
//            if let data = NSData(contentsOfURL: nsurl) {
//                let json = JSON(data: data)
//                return json
//            } else {
//                return nil
//            }
//        } else {
//            return nil
//        }
//        
//    }
    
//    func cacheImages() {
//        
//        //NSURL
//        //NSData
//        //UIImage
//        
//        for item in theData {
//            
//            let url = NSURL(string: item.url)
//            let data = NSData(contentsOfURL: url!)
//            let image = UIImage(data: data!)
//            
//            theImageCache.append(image!)
//            
//            
//        }
//        
//    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("I have \(favoriteMovieTitles.count) items in my array")
        numRows = favoriteMovieTitles.count + 1
        return favoriteMovieTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       
        
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = favoriteMovieTitles[indexPath.row]
//        cell.detailTextLabel?.text = theData[indexPath.row].description
//        cell.imageView?.image = theImageCache[indexPath.row]
        
        return cell
    }
    
    func showModal() {
        let modalViewController = self.storyboard?.instantiateViewControllerWithIdentifier("modalVC") as! ModalViewController
        self.presentViewController(modalViewController, animated: true, completion: nil)
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        showModal()
        
    }
    
    override func viewWillAppear(animated: Bool){
        print("numRows: " + String(numRows))
        if numRows > 0 {
            topLabel.hidden = true
            middleImage.hidden = true
            bottomLabel.hidden = true
        }
        
        
        let temp = NSUserDefaults.standardUserDefaults().arrayForKey("favoriteMovieIDs")
        print(temp)
        self.title = "First"
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
            self.fetchDataForTableView()
            //self.cacheImages()
            
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
        
    }


}

