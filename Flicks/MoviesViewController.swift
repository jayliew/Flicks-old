//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Jay Liew on 2/7/16.
//  Copyright © 2016 Jay Liew. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadDataFromNetwork()
    }

    func loadDataFromNetwork() {
        
        // ... Create the NSURLRequest (myRequest) ...
        let clientId = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(clientId)")
        let request = NSURLRequest(URL: url!)

        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, responseOrNil, errorOrNil) in
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)

                if let requestError = errorOrNil {
                    //                    errorCallback?(requestError)
                } else {
                    if let data = dataOrNil {
                        if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                            data, options:[]) as? NSDictionary {
                                                                NSLog("response: \(responseDictionary)")
                                self.movies = responseDictionary["results"] as? [NSDictionary]
                                //                                successCallback(responseDictionary)
                        }
                    }
                }
        });
        task.resume()
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! MovieDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        // Question: Why does the URL have to be accessed like this? PITA
        let movie = movies![indexPath!.item]
        let overview = movie["overview"] as! String
        let title = movie["title"] as! String
        let poster = movie["poster_path"] as! String
        let url = "https://image.tmdb.org/t/p/w342"
        let imageUrl = NSURL(string: url + poster)
        
        vc.photoView.setImageWithURL(imageUrl!)
        vc.titleLabel.text = title
        vc.overviewTextView.text = overview
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.jayliew.MovieViewCell", forIndexPath: indexPath) as! MovieViewCell

        let movie = movies![indexPath.item]
        let overview = movie["overview"] as! String
        let title = movie["title"] as! String
        let poster = movie["poster_path"] as! String
        let url = "https://image.tmdb.org/t/p/w342"
        let imageUrl = NSURL(string: url + poster)
        
        cell.photoView.setImageWithURL(imageUrl!)
        cell.titleLabel.text = title
        cell.overviewTextView.text = overview
        print(imageUrl)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies)
        if let movies = movies as [NSDictionary]? {
            print("rows: " + String(movies.count))
            return movies.count
        }else{
            print("rows: ZERO")
            return 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class Post {
    class func fetchPosts(successCallback: (NSDictionary) -> Void, errorCallback: ((NSError?) -> Void)?) {
        let clientId = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, responseOrNil, errorOrNil) in
                if let requestError = errorOrNil {
                    errorCallback?(requestError)
                } else {
                    if let data = dataOrNil {
                        if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                            data, options:[]) as? NSDictionary {
                                NSLog("response: \(responseDictionary)")
                                successCallback(responseDictionary)
                        }
                    }
                }
        });
        task.resume()
    }
}