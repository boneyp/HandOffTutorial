//
//  ContactViewController.swift
//  HandOffTutorial
//
//  Created by Boney Philip on 3/22/15.
//  Copyright (c) 2015 iospool. All rights reserved.
//

import UIKit

class ContactViewController: UITableViewController,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView (tableView:UITableView, numberOfRowsInSection section: Int)->Int{
        return 4
    }
    
    override func tableView (tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)-> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel!.text = "Test"
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
