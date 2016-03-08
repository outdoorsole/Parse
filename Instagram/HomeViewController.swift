//
//  HomeViewController.swift
//  Instagram
//
//  Created by Mari Gordon on 3/7/16.
//  Copyright © 2016 Maribel Montejano. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(PFUser.currentUser() == nil) {
            performSegueWithIdentifier("loginSegue", sender: self)
        } else {
            
            var query = PFQuery(className: "Post")
            
            // fetch data asynchronously
            query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
                if let posts = posts {
                    self.posts = posts
                    self.tableView.reloadData()
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        PFUser.logOutInBackground()
        performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (posts != nil) {
            return posts!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostCell
        cell.post = posts![indexPath.row]
        return cell
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
