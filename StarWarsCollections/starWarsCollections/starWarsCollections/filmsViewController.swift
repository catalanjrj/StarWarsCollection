//
//  Films.swift
//  starWarsCollections
//
//  Created by Jorge Catalan on 8/11/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FilmsController: UIViewController {
    
    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://swapi.co/api/films/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                    print(resData)
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("jsonCell")!
        var dict = arrRes[indexPath.row]
        cell.textLabel?.text = dict["title"] as? String
        cell.detailTextLabel?.text = dict["episode_id"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let detailsViewController = segue.destinationViewController as? detailsViewController {
            if let indexPath = self.tblJSON?.indexPathForSelectedRow {
                
                detailsViewController.recieved = self.arrRes[indexPath.row] as? String
            }
        }
    }

    
}

