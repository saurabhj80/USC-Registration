//
//  CourseTableViewController.swift
//  USC Reg
//
//  Created by Chaitu on 2/21/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

protocol CourseTableViewControllerDelegate {
    
    func reloadCourseTable(controller: CourseTableViewController)
    
}

class CourseTableViewController: UITableViewController {
    
    var departmentCode : String?
    var departmentName : String?
    var courseList = [course]()
    var delegate: CourseTableViewControllerDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseList = localStorage.getCourseByDept(departmentCode!)
        self.title = departmentName
                
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        courseList = []
        delegate = localStorage()
        delegate?.reloadCourseTable(self)
        self.title = departmentName 
        
        localStorage.addSectiontoCourseBin("6780")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return courseList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = courseList[indexPath.row].sisCourseID + ": " + courseList[indexPath.row].title

        // Configure the cell...
        cell.textLabel?.font = UIFont(name: "GillSans-Light", size: 18)
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        
        var courseInfo = segue.destinationViewController as CourseDetailsViewController
        // Pass the selected object to the new view controller.
        
        if let indexPath = self.tableView.indexPathForSelectedRow(){

           courseInfo.currentCourse = courseList[indexPath.row]
            
            println(courseList[indexPath.row].description)
        }
    }


    

}
