//
//  SearchResultsTableViewController.swift
//  USC Web Registration
//
//  Created by Darvish Kamalia on 2/27/15.
//  Copyright (c) 2015 Darvish Kamalia. All rights reserved.
//

import UIKit

protocol SearchResultsTableViewControllerDelegate {
    
 
    func searchForCourses (keywords: String, coursename: String, deptname: String, units: Double, controller: SearchResultsTableViewController)
    
}


class SearchResultsTableViewController: UITableViewController {
    
    var courseList = [course]()
    var delegate: SearchResultsTableViewControllerDelegate? = nil
    
    var keywords: String?
    var coursename: String?
    var deptname: String?
    var units: Double?

    var activity = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Up the Activity Indicator
        activity.frame = CGRectMake(CGRectGetMidX(self.tableView.bounds) - 22, CGRectGetMidY(self.view.bounds) - 22, 44.0, 44.0)
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.tableView.addSubview(activity)
        
        
        activity.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        delegate = localStorage()
        delegate?.searchForCourses(keywords!, coursename: coursename!, deptname: deptname!, units: units!, controller: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return courseList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = courseList[indexPath.row].sisCourseID + ": " + courseList[indexPath.row].title
        
        // Configure the cell...
        cell.textLabel?.font = UIFont(name: "GillSans-Light", size: 18)
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        
        var courseInfo = segue.destinationViewController as CourseDetailsViewController
        // Pass the selected object to the new view controller.
        
        if let indexPath = self.tableView.indexPathForSelectedRow(){
            
            courseInfo.currentCourse = courseList[indexPath.row]
            
           // println(courseList[indexPath.row].description)
        }
    }
    
    

   }
