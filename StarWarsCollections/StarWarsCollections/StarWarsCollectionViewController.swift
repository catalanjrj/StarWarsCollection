//
//  StarWarsCollectionViewController.swift
//  StarWarsCollections
//
//  Created by Jorge Catalan on 7/20/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "movieCell"

class StarWarsCollectionViewController: UICollectionViewController {
    var results = [[String:AnyObject]]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: NSURLSession
        let requestURL: NSURL = NSURL(string: "https://swapi.co/api/films/")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("success")
                
                
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    if let results = json["results"] as? [[String:AnyObject]] {
                        for result in results {
                            if let title = result["title"] as? String {
                                if let episode = result["episode_id"] as? Int {
                                    if let description = result["opening_crawl"] as? String {
                                        
                                        let sortedResults = results.sort({ $0.indexForKey("episode_id") > $1.indexForKey("episode_id")})
                                        
                                    
                                        self.results = sortedResults
                                        // Create a new Film object
                                        _ = Film(title:title, episode: episode, description: description)
                                        
                                        print("\(title) \(episode)")
                                        
                                        dispatch_async(dispatch_get_main_queue(), {
                                            self.collectionView?.reloadData()
                                        })
                                    }
                                    
                                }
                            }
                        }
                    }
                } catch {
                    print("Error with JSON: \(error)")
                }
            }
        }
        
        
        task.resume()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "swapiCell")
        // Do any additional setup after loading the view.
    }
    
    // TODO: We need to do something with this 'results' object, use it to populate the CollectionView
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return results.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("swapiCell", forIndexPath: indexPath) as UICollectionViewCell
        
        
        // Configure the cell
        cell.contentView.backgroundColor = UIColor.lightGrayColor()
        
        let titleLabel: UILabel = UILabel()
        titleLabel.frame = CGRect( x: 5,y: 20 , width: (cell.contentView.frame.width - 20), height: ((cell.contentView.frame.height - 30) / 4))
        titleLabel.backgroundColor = UIColor.blackColor()
        titleLabel.textColor = UIColor.yellowColor()
        
        titleLabel.text = String(results[indexPath.row]["title"]!)
        
        let episodeLabel: UILabel = UILabel()
        episodeLabel.frame = CGRect(x: 5, y: 100, width: titleLabel.frame.width, height: titleLabel.frame.height)
        episodeLabel.backgroundColor = UIColor.blackColor()
        episodeLabel.textColor = UIColor.yellowColor()
        
        episodeLabel.text = String(results[indexPath.row]["episode_id"]!)
        
        
        cell.addSubview(titleLabel)
        cell.addSubview(episodeLabel)
        
        return cell
}
}