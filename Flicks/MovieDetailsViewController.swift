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
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    var photoUrl = NSURL()
    var movieTitle = String()
    var movieOverview = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        self.photoView.setImageWithURL(self.photoUrl)
        self.titleLabel.text = self.movieTitle
        self.overviewLabel.text = self.movieOverview
        self.overviewLabel.sizeToFit()

        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        
//        let navBarAppearance = UINavigationBar.appearance()
//        let colorImage = UIImage.imageFromColor(UIColor.morselPink(), frame: CGRectMake(0, 0, 340, 64))
//        navBarAppearance.setBackgroundImage(colorImage, forBarMetrics: .Default)
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
