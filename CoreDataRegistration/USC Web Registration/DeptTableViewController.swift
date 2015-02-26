//
//  DeptTableViewController.swift
//  USC Reg
//
//  Created by Chaitu on 2/21/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class DeptTableViewController: UITableViewController {
    
    var schoolname : String?
    var schoolcode : String?
    var deptArray = [department]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        deptArray = localStorage.getDeptBySchool(schoolcode!)
        self.title = schoolname!
                
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return deptArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeptCell", forIndexPath: indexPath) as UITableViewCell

        var deptName = deptArray[indexPath.row].departmentDescription
        cell.textLabel?.text = deptName
        // Configure the cell...

        // Customizing the Appearance of the cell
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.textLabel?.font = UIFont(name: "GillSans-Light", size: 18.0)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        return self.tableView.rowHeight
        
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        
        var courseView = segue.destinationViewController as CourseTableViewController
        // Pass the selected object to the new view controller.
        
        if let indexPath = self.tableView.indexPathForSelectedRow(){
           courseView.departmentCode = deptArray[indexPath.row].departmentCode
            courseView.departmentName = deptArray[indexPath.row].departmentDescription
            
        }
        
    }
    

}
