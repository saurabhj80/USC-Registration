//
//  CourseBinTableViewController.swift
//  USC Reg
//
//  Created by Saurabh Jain on 2/22/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit


class CourseBinTableViewController: UITableViewController  {

    var arr:[section] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        var v:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 50))
        v.text = "Course Bin"
        v.textColor = UIColor.whiteColor()
        v.font = UIFont(name: "GillSans-light", size: 22)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 189.0/256, green: 125.0/256, blue: 128.0/256, alpha: 1)
        self.navigationItem.titleView = v
        
        arr = localStorage.getCurrentSections()
        
        self.tableView.reloadData()
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
