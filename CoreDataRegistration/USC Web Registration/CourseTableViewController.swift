//
//  CourseTableViewController.swift
//  USC Reg
//
//  Created by Chaitu on 2/21/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class CourseTableViewController: UITableViewController {
    
    var departmentCode : String!
    var departmentName : String!
    var courseList = [course]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(departmentCode)
        courseList = localStorage.getCourseByDept(departmentCode!)
        self.title = departmentName
        
        //println(courseList)
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(animated: Bool) {

    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = courseList[indexPath.row].sisCourseID + ": " + courseList[indexPath.row].title

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
        
        var courseInfo = segue.destinationViewController as CourseDetailsViewController
        
        if let indexPath = self.tableView.indexPathForSelectedRow(){

           courseInfo.currentCourse = courseList[indexPath.row]
        }
    }


    

}
