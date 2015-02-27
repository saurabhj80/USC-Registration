//
//  CourseBinTableViewController.swift
//  USC Reg
//
//  Created by Saurabh Jain on 2/22/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

protocol CourseBinTableViewControllerDelegate {
 
    func reloadCourses (controller: CourseBinTableViewController)
    
}


class CourseBinTableViewController: UITableViewController  {
    
    var arr:[section] = [];
    var delegate:CourseBinTableViewControllerDelegate? = nil
    
    var activity:UIActivityIndicatorView = UIActivityIndicatorView()

    var v1:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Up the Activity Indicator
        activity.frame = CGRectMake(CGRectGetMidX(self.tableView.bounds) - 22, CGRectGetMidY(self.view.bounds) - 22, 44.0, 44.0)
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.tableView.addSubview(activity)
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Title
        var v:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 50))
        v.text = "Course Bin"
        v.textColor = UIColor.whiteColor()
        v.font = UIFont(name: "GillSans-light", size: 22)
        
        // Navigation Bar Appearance
        self.navigationItem.titleView = v
        
        
        v1 = UILabel(frame: CGRectMake(CGRectGetMidX(self.tableView.bounds) - self.tableView.bounds.size.width/2, CGRectGetMidY(self.tableView.bounds) - 100, self.tableView.bounds.size.width, 100))
        v1.text = "No Courses in the bin."
        v1.font = UIFont(name: "GillSans-Light", size: 22.0);
        v1.numberOfLines = 0;
        v1.textAlignment = NSTextAlignment.Center
        self.tableView.addSubview(v1)
        v1.hidden = true
        // Get the sections cuurently enrolled in
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        println("RELDJFLKAJSLKF AKFJ ASKJF LKASJF LKASJFLK JA")
        self.refresh()
    }
    
    func refresh()
    {
        activity.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        //arr = localStorage.getCurrentSections()
        
        arr = []
        delegate = localStorage()
        delegate?.reloadCourses(self)
        
        if arr.count == 0 {
           v1.hidden = false
        } else {
            println("Hiding")
            v1.hidden = true
        }
        
        activity.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arr.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.arr[indexPath.row].sisCourseID
        cell.textLabel?.font = UIFont(name: "GillSans-light", size: 22)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }
    
    // MARK : Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.performSegueWithIdentifier("details", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "details"
        {
            var vc:DetailsViewController = segue.destinationViewController as DetailsViewController
            
            var indexPath:NSIndexPath = sender as NSIndexPath
            
            var object:section! = self.arr[indexPath.row]
            
            if let obj = object{
                
                vc.arr.addObject(obj.sisCourseID)
                vc.arr.addObject(obj.type)
                vc.arr.addObject("\(obj.units)")
                vc.arr.addObject(obj.instructor)
                vc.arr.addObject(obj.section)
                vc.arr.addObject(obj.location)
                vc.arr.addObject(obj.beginTime)
                vc.arr.addObject(obj.endTime)
            }
            
        }
        
    }
    
}