//
//  DisLecLabTableViewController.swift
//  USC Reg
//
//  Created by Chaitu on 2/26/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class DisLecLabTableViewController: UITableViewController {
    
    
    var courseSections : course?
    var lectures = [section]()
    var discussion = [section]()
    var quiz = [section]()
    var labs = [section]()
    var selectedSections = [section]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var allSections = [section]()
        allSections = localStorage.getSectionsByCourse(courseSections!.sisCourseID)
        
        for sections in allSections
        {
            if sections.type == "Lecture"{
                lectures.append(sections)
            
            }
            else if sections.type == "Lab"{
                labs.append(sections)
            }
            else if sections.type == "Discussion"{
                discussion.append(sections)
            }
            else{
                quiz.append(sections)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Add(sender: AnyObject) {
        
        for sections in selectedSections{
            localStorage.addSectiontoCourseBin(sections.section)
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
          return lectures.count
            
        }
        
        if section == 1 {
            return discussion.count
            
        }
        
        if section == 2 {
            return labs.count
            
        }
        
        if section == 3 {
            return quiz.count
            
        }
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DisLecCell", forIndexPath: indexPath) as UITableViewCell
        
       

        if indexPath.section == 0 {
            cell.textLabel?.text = "Lecture Section: " + lectures[indexPath.row].section
            cell.detailTextLabel?.text = lectures[indexPath.row].instructor + "     " + lectures[indexPath.row].beginTime + "-" + lectures[indexPath.row].endTime + "    " + lectures[indexPath.row].day
            
        }
        
        if indexPath.section == 1 {
            cell.textLabel?.text = "Discussion Section: " + discussion[indexPath.row].section
            cell.detailTextLabel?.text = discussion[indexPath.row].beginTime + "-" + discussion[indexPath.row].endTime + "    " + discussion[indexPath.row].day
            
        }
        
        if indexPath.section == 2 {
            cell.textLabel?.text = "Lab Section: " + labs[indexPath.row].section
            cell.detailTextLabel?.text = labs[indexPath.row].beginTime + "-" + labs[indexPath.row].endTime + "    " + labs[indexPath.row].day
        }
        
        if indexPath.section == 3{
            cell.textLabel?.text = "Quiz Section: " + quiz[indexPath.row].section
            cell.detailTextLabel?.text = quiz[indexPath.row].beginTime + "-" + quiz[indexPath.row].endTime + "    " + quiz[indexPath.row].day
            
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Lectures"
        }
        else if section == 1{
            return "Discussion"
        }
        else if section == 2{
            return "Labs"
        }
        else{
            return "Quiz"
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        
              
        
        if cell?.accessoryType == UITableViewCellAccessoryType.None
        {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                
                var sectionType = indexPath.section
                if sectionType == 0{
                    selectedSections.append(lectures[indexPath.row])
                for items in selectedSections{
                    println(items.section)
                }
               }
                else if sectionType == 1{
                    selectedSections.append(discussion[indexPath.row])
                    for items in selectedSections{
                        println(items.section)
                    }
                }
                else if sectionType == 2{
                    selectedSections.append(labs[indexPath.row])
                    for items in selectedSections{
                        println(items.section)
                    }
                }
                else {
                    selectedSections.append(quiz[indexPath.row])
                    for items in selectedSections{
                        println(items.section)
                    }
                }
            }
        }
        else{
            cell?.accessoryType = UITableViewCellAccessoryType.None
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                
                var sectionType = indexPath.section
                if sectionType == 0
                {
                    var sectionID = lectures[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                        
                    }
                   
                }
                else if sectionType == 1{
                    var sectionID = discussion[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                        
                    }
                   
                }
                else if sectionType == 2{
                    var sectionID = labs[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                        
                    }
                   
                }
                else {
                    var sectionID = quiz[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                        
                    }
                  
                }
            }
        }
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

/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var courseBin = segue.destinationViewController as someViewController
        // Get the new view controller using [segue destinationViewController].
        
        courseBin.toAddClasses = selectedSections
        // Pass the selected object to the new view controller.
    }
    
*/
}
