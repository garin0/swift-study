//
//  ViewController.swift
//  UserLoginAndRegistration
//
//  Created by Sergey Kargopolov on 2015-01-08.
//  Copyright (c) 2015 Sergey Kargopolov. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   override func viewDidAppear(animated: Bool)
   {
    
    let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
    
    if(!isUserLoggedIn)
    {
         self.performSegueWithIdentifier("loginView", sender: self);
    }
    

   }
    
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
    NSUserDefaults.standardUserDefaults().setBool(false,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        PFUser.logOutInBackgroundWithBlock({ (error: NSError?) -> Void in
        self.performSegueWithIdentifier("loginView", sender: self);
        })
        
        

        
    }
    
    @IBAction func openURL(sender: AnyObject) {
        let url : NSURL = NSURL(string: "http://192.168.0.138:8080/first/")!
        //192.168.0.138:8080/first/
        UIApplication.sharedApplication().openURL(url)
    }
    


}

