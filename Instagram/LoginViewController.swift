//
//  LoginViewController.swift
//  Instagram
//
//  Created by Maribel Montejano on 2/27/16.
//  Copyright © 2016 Maribel Montejano. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSignIn(sender: AnyObject) {
        // PFUser handles the functionality for user account management. It has several properties:
        // username (required)
        // password (required)
        // email (optional)
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("you're logged in!")
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        // Initialize a user object
        let newUser = PFUser()
        
        // Set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text

        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("User Registered successfully!")
            } else {
                print(error!.localizedDescription)
                if error?.code === 202 {
                    print("Username is taken")
                }
            }
        }
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
