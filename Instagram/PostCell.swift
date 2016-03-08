//
//  PostCell.swift
//  Instagram
//
//  Created by Mari Gordon on 3/7/16.
//  Copyright © 2016 Maribel Montejano. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {


    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var postPic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var caption: UILabel!
    
    
    var post: PFObject? {
        didSet {
            let caption = post?.objectForKey("caption") as! String
            let author = post?.objectForKey("author") as! PFUser
            let media = post?.objectForKey("media") as! PFFile
            
            self.caption.text = caption
//            self.username.text = author.username
            media.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                let image = UIImage(data: data!)
                self.postPic.image = image
            }
            

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePic.layer.cornerRadius = profilePic.frame.size.width
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
