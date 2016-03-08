//
//  ComposeViewController.swift
//  Instagram
//
//  Created by Mari Gordon on 3/7/16.
//  Copyright © 2016 Maribel Montejano. All rights reserved.
//

import UIKit
import Parse

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        image.contentMode = .ScaleAspectFit
        
        caption.delegate = self
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        
        submit.alpha = 0
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        
        var captionText = caption.text
        if captionText == "Caption" {
            captionText = ""
        }
        
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image.image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = captionText
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock { (complete: Bool, error: NSError?) -> Void in
            // 
            self.navigationController?.popViewControllerAnimated(true)

        }
   
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.blackColor();
        textView.becomeFirstResponder();
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder();
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController

            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            image.image = editedImage
            
            // Do something with the images (based on your use case)
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
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
