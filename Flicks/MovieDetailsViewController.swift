//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Jay Liew on 2/7/16.
//  Copyright © 2016 Jay Liew. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailsViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    var photoUrl = NSURL()
    var movieTitle = String()
    var movieOverview = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoView.setImageWithURL(self.photoUrl)
        self.titleLabel.text = self.movieTitle
        self.overviewTextView.text = self.movieOverview

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
