//
//  CourseBinTableViewController.swift
//  USC Reg
//
//  Created by Saurabh Jain on 2/22/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class CourseBinTableViewController: UITableViewController , EKEventEditViewDelegate {

    var arr:[section] = [];
    var eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.navigationItem.title = "Course Bin"
        self.navigationController?.navigationBar.titleTextAttributes = NSDictionary(objectsAndKeys: UIColor.blackColor(),NSForegroundColorAttributeName, UIFont(name: "GillSans-light", size: 22)!, NSFontAttributeName)
        arr = localStorage.getCurrentSections()
        self.tableView.reloadData()
    }


   // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CourseBinTableViewCell
        
        var obj:section = self.arr[indexPath.row]
        
        cell.name?.text = obj.sisCourseID
        cell.type.text = obj.type
        cell.unit.text = "\(obj.units)"
        cell.beginTime.text = obj.beginTime
        cell.location.text = obj.location
        cell.section.text = obj.section;
        
        if obj.instructor != "na"
        {
            cell.instructor.text = obj.instructor
            
        } else {
            
            cell.instructor.text = ""
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200;
    }
    
    // MARK : Table View Delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.createEvent(indexPath)
    }
    
    // Helper method
    
    func createEvent(indexPath: NSIndexPath)
    {
        var formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh a";
        formatter.locale = NSLocale.currentLocale()
        
        var obj = self.arr[indexPath.row]
        
        var date = NSDate()
        var year = NSCalendar.currentCalendar().component(NSCalendarUnit.YearCalendarUnit, fromDate: date)
        var month = NSCalendar.currentCalendar().component(NSCalendarUnit.MonthCalendarUnit, fromDate: date)
        var day = NSCalendar.currentCalendar().component(NSCalendarUnit.DayCalendarUnit, fromDate: date)
        
        obj.beginTime = "\(year)-" + "\(month)-" + "\(day)" + " " + obj.beginTime
        obj.endTime = "\(year)-" + "\(month)-" + "\(day)" + " " + obj.endTime
        
        var startdate:NSDate = formatter.dateFromString(obj.beginTime)!
        var endDate:NSDate   = formatter.dateFromString(obj.endTime)!
        
        var event = EKEvent(eventStore: eventStore)
        event.startDate = startdate
        event.endDate = endDate
        event.availability = EKEventAvailabilityBusy
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        eventStore.requestAccessToEntityType(EKEntityTypeEvent) { (success, error) -> Void in
            
            if(success)
            {
                var eventview = EKEventEditViewController()
                eventview.event = event
                eventview.eventStore = self.eventStore
                eventview.editViewDelegate = self;
                
                self.presentViewController(eventview, animated: true, completion: nil)
            }
        }

    }
    
    // MARK : EKEvent Edit View Delegate
    
    func eventEditViewController(controller: EKEventEditViewController!, didCompleteWithAction action: EKEventEditViewAction)
    {
        if action.value == 0
        {
            // Dismiss
            
        } else if action.value == 1{

            var error:NSError?;
            controller.eventStore.saveEvent(controller.event, span: EKSpanFutureEvents, commit: true, error: &error)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func eventEditViewControllerDefaultCalendarForNewEvents(controller: EKEventEditViewController!) -> EKCalendar! {
        return eventStore.defaultCalendarForNewEvents
    }
    
}
