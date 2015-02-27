//
//  DetailsViewController.swift
//  USC Reg
//
//  Created by Saurabh Jain on 2/23/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class DetailsViewController: UIViewController, EKEventEditViewDelegate {
    
    // IBOutlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ins: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var begin: UILabel!
    @IBOutlet weak var loc: UILabel!
    
    var arr:NSMutableArray = []
    
    var eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        name.text    = arr[0] as? String
        type.text    = arr[1] as? String
        unit.text    = arr[2] as? String
        section.text = arr[4] as? String
        loc.text     = arr[5] as? String
        begin.text   = arr[6] as? String
        
        if arr[3] as NSString == "na" {
            ins.text = ""
        } else {
            ins.text = arr[3] as? String
        }
        
    }
    
    @IBAction func addToCalender(sender: UIButton)
    {
        // Call Helper Method
        self.createEvent()
    }
    
    // Helper method
    
    func createEvent()
    {
        var formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm";
        formatter.locale = NSLocale.currentLocale()
        
        var date = NSDate()
        var year = NSCalendar.currentCalendar().component(NSCalendarUnit.YearCalendarUnit, fromDate: date)
        var month = NSCalendar.currentCalendar().component(NSCalendarUnit.MonthCalendarUnit, fromDate: date)
        var day = NSCalendar.currentCalendar().component(NSCalendarUnit.DayCalendarUnit, fromDate: date)
        
        var begin:String! = arr[6] as? String
        var end:String! = arr[7] as? String
        
        begin = "\(year)-" + "\(month)-" + "\(day)" + " " + begin
        end   = "\(year)-" + "\(month)-" + "\(day)" + " " + end
        
        var startdate:NSDate! = formatter.dateFromString(begin)
        var endDate:NSDate!   = formatter.dateFromString(end)
        
        println(startdate)
        println(endDate)
        
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
        if action.value == 1{
            
            var error:NSError?;
            controller.eventStore.saveEvent(controller.event, span: EKSpanFutureEvents, commit: true, error: &error)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func eventEditViewControllerDefaultCalendarForNewEvents(controller: EKEventEditViewController!) -> EKCalendar! {
        return eventStore.defaultCalendarForNewEvents
    }
    
    // IBAction - Dismiss View Controller
    
    @IBAction func cancel(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}