//
//  DisLecLabTableViewController.swift
//  USC Reg
//
//  Created by Chaitu on 2/26/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

protocol DisLecLabTableViewControllerDelegate {
 
    func reloadDisLecLabTable(controller: DisLecLabTableViewController)
    
}

class DisLecLabTableViewController: UITableViewController {
    
    
    var courseSections : course?
    var lectures = [section]()
    var discussion = [section]()
    var quiz = [section]()
    var labs = [section]()
    var other = [section]()
    var selectedSections = [section]()
    var allSections = [section]()
    var delegate: DisLecLabTableViewControllerDelegate? = nil
    var nothingSelectedLecture = true
    var nothingSelectedDiscussion = true
    var nothingSelectedQuiz = true
    var nothingSelectedLab = true
    var nothingSelectedOther = true
    
    /*var checkedLectures = [Bool]()
    var checkedDiscussion = [Bool]()
    var checkedQuiz = [Bool]()
    var checkedLabs = [Bool]()
    var checkekOther = [Bool]()
    */
    
    var activity = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // var allSections = [section]()
        //allSections = localStorage.getSectionsByCourse(courseSections!.sisCourseID)
       
        tableView.reloadData()
     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Setting Up the Activity Indicator
        activity.frame = CGRectMake(CGRectGetMidX(self.tableView.bounds) - 22,CGRectGetMidY(self.tableView.bounds) - 22, 44.0, 44.0)
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.view.addSubview(activity)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //activity.startAnimating()
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        delegate = localStorage()
        delegate?.reloadDisLecLabTable(self)
        tableView.reloadData()
        println(allSections.count)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Add(sender: AnyObject) {
        
        activity.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        for sections in selectedSections{
            println("VIEWCONTROLLER")
            println (sections.sectionID)
            localStorage.addSectiontoCourseBin(sections.sectionID)
        }
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("someSelector"), userInfo: nil, repeats: false)
    }
    
    func someSelector() {
        // Something after a delay
        
        activity.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 5
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
        
        if section == 4 {
            return other.count
        }
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DisLecCell", forIndexPath: indexPath) as UITableViewCell
        
       println("here")

        if indexPath.section == 0 {
            cell.textLabel?.text = " Section: " + lectures[indexPath.row].section
            cell.detailTextLabel?.text = lectures[indexPath.row].instructor + "     " + lectures[indexPath.row].beginTime + "-" + lectures[indexPath.row].endTime + "    " + lectures[indexPath.row].day
            
            
            if lectures[indexPath.row].checked == 0
            {
               
               /* if nothingSelectedLecture == false{
                    cell.userInteractionEnabled = false
                    cell.textLabel?.enabled = false
                    cell.detailTextLabel?.enabled = false
                }
*/
                
                cell.accessoryType = UITableViewCellAccessoryType.None
            
               
                
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                /*
                cell.userInteractionEnabled = true
                cell.textLabel?.enabled = true
                cell.detailTextLabel?.enabled = true
                */

            }
            
            if nothingSelectedLecture == false
            {
                if(lectures[indexPath.row].checked == 1)
                {
                    cell.userInteractionEnabled = true
                    cell.textLabel?.enabled = true
                    cell.detailTextLabel?.enabled = true
                }
                else{
                    cell.userInteractionEnabled = false
                    cell.textLabel?.enabled = false
                    cell.detailTextLabel?.enabled = false
                }
               
            }
            else
            {
                cell.userInteractionEnabled = true
                cell.textLabel?.enabled = true
                cell.detailTextLabel?.enabled = true
            }
            
        }
        
        if indexPath.section == 1 {
            cell.textLabel?.text = "Section: " + discussion[indexPath.row].section
            cell.detailTextLabel?.text = discussion[indexPath.row].beginTime + "-" + discussion[indexPath.row].endTime + "    " + discussion[indexPath.row].day
            
            if discussion[indexPath.row].checked == 0
            {
                cell.accessoryType = UITableViewCellAccessoryType.None
               
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                
            }
            if nothingSelectedDiscussion == false
            {
                if(discussion[indexPath.row].checked == 1)
                {
                    cell.userInteractionEnabled = true
                    cell.textLabel?.enabled = true
                    cell.detailTextLabel?.enabled = true
                }
                else{
                    cell.userInteractionEnabled = false
                    cell.textLabel?.enabled = false
                    cell.detailTextLabel?.enabled = false
                }
                
            }
            else
            {
                cell.userInteractionEnabled = true
                cell.textLabel?.enabled = true
                cell.detailTextLabel?.enabled = true
            }

        }
        
        if indexPath.section == 2 {
            cell.textLabel?.text = "Section: " + labs[indexPath.row].section
            cell.detailTextLabel?.text = labs[indexPath.row].beginTime + "-" + labs[indexPath.row].endTime + "    " + labs[indexPath.row].day
            
            if labs[indexPath.row].checked == 0
            {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                
            }
            if nothingSelectedLab == false
            {
                if(labs[indexPath.row].checked == 1)
                {
                    cell.userInteractionEnabled = true
                    cell.textLabel?.enabled = true
                    cell.detailTextLabel?.enabled = true
                }
                else{
                    cell.userInteractionEnabled = false
                    cell.textLabel?.enabled = false
                    cell.detailTextLabel?.enabled = false
                }
                
            }
            else
            {
                cell.userInteractionEnabled = true
                cell.textLabel?.enabled = true
                cell.detailTextLabel?.enabled = true
            }

        }
        
        if indexPath.section == 3{
            cell.textLabel?.text = "Section: " + quiz[indexPath.row].section
            cell.detailTextLabel?.text = quiz[indexPath.row].beginTime + "-" + quiz[indexPath.row].endTime + "    " + quiz[indexPath.row].day
            
            if quiz[indexPath.row].checked == 0
            {
                cell.accessoryType = UITableViewCellAccessoryType.None
                
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
               
            }
            if nothingSelectedQuiz == false
            {
                if(quiz[indexPath.row].checked == 1)
                {
                    cell.userInteractionEnabled = true
                    cell.textLabel?.enabled = true
                    cell.detailTextLabel?.enabled = true
                }
                else{
                    cell.userInteractionEnabled = false
                    cell.textLabel?.enabled = false
                    cell.detailTextLabel?.enabled = false
                }
                
            }
            else
            {
                cell.userInteractionEnabled = true
                cell.textLabel?.enabled = true
                cell.detailTextLabel?.enabled = true
            }

            
        }
        
        if indexPath.section == 4{
            cell.textLabel?.text = "Section: " + other[indexPath.row].section
            cell.detailTextLabel?.text = other[indexPath.row].beginTime + "-" + other[indexPath.row].endTime + "    " + other[indexPath.row].day
            
            if other[indexPath.row].checked == 0
            {
                cell.accessoryType = UITableViewCellAccessoryType.None
                
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
               
            }
            if nothingSelectedOther == false
            {
                if(other[indexPath.row].checked == 1)
                {
                    cell.userInteractionEnabled = true
                    cell.textLabel?.enabled = true
                    cell.detailTextLabel?.enabled = true
                }
                else{
                    cell.userInteractionEnabled = false
                    cell.textLabel?.enabled = false
                    cell.detailTextLabel?.enabled = false
                }
                
            }
            else
            {
                cell.userInteractionEnabled = true
                cell.textLabel?.enabled = true
                cell.detailTextLabel?.enabled = true
            }

            
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
        else if section == 3{
            return "Quiz"
        }
        else{
            return "Other"
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
                    lectures[indexPath.row].checked = 1;
                    nothingSelectedLecture = false
                    selectedSections.append(lectures[indexPath.row])
                    
                    
                    for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        println("changed lecture")
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        if(indexPathForDisablingInteraction != indexPath)
                        {
                        cell?.userInteractionEnabled = false
                        cell?.textLabel?.enabled = false
                        cell?.detailTextLabel?.enabled = false
                        }
                    }


             
                
               }
                else if sectionType == 1{
                    println("changed labs")
                    discussion[indexPath.row].checked = 1;
                    nothingSelectedDiscussion = false
                    selectedSections.append(discussion[indexPath.row])
                    
                   for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        if(indexPathForDisablingInteraction != indexPath)
                        {
                            cell?.userInteractionEnabled = false
                            cell?.textLabel?.enabled = false
                            cell?.detailTextLabel?.enabled = false
                        }
                    }
                
                
                }
                else if sectionType == 2{
                    println("changed quiz")
                     labs[indexPath.row].checked = 1;
                    nothingSelectedLab = false
                    selectedSections.append(labs[indexPath.row])
                   
                   for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        if(indexPathForDisablingInteraction != indexPath)
                        {
                            cell?.userInteractionEnabled = false
                            cell?.textLabel?.enabled = false
                            cell?.detailTextLabel?.enabled = false
                        }
                    }
                    
                    
                }
                else if sectionType == 3{
                    println("changed quizzes")
                    quiz[indexPath.row].checked = 1;
                    nothingSelectedQuiz = false
                    selectedSections.append(quiz[indexPath.row])
                    quiz[indexPath.row].checked = 1;
                    for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        if(indexPathForDisablingInteraction != indexPath)
                        {
                            cell?.userInteractionEnabled = false
                            cell?.textLabel?.enabled = false
                            cell?.detailTextLabel?.enabled = false
                        }
                    }
                    
                }
                else{
                    other[indexPath.row].checked = 1;
                    nothingSelectedOther = false
                    selectedSections.append(other[indexPath.row])
                    
                    for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        if(indexPathForDisablingInteraction != indexPath)
                        {
                            cell?.userInteractionEnabled = false
                            cell?.textLabel?.enabled = false
                            cell?.detailTextLabel?.enabled = false
                        }
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
                    lectures[indexPath.row].checked = 0;
                    nothingSelectedLecture = true
                    var sectionID = lectures[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                        
                    }
                  
                    for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        
                            cell?.userInteractionEnabled = true
                            cell?.textLabel?.enabled = true
                            cell?.detailTextLabel?.enabled = true
                        
                    }
               
                }
                else if sectionType == 1{
                    discussion[indexPath.row].checked = 0;
                    nothingSelectedDiscussion = true
                    var sectionID = discussion[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                        
                        
                    }
                    for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        
                        cell?.userInteractionEnabled = true
                        cell?.textLabel?.enabled = true
                        cell?.detailTextLabel?.enabled = true
                        
                    }

                   
                }
                else if sectionType == 2{
                    labs[indexPath.row].checked = 0;
                    nothingSelectedLab = true
                    var sectionID = labs[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                       
    
                    }
                    for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        
                        cell?.userInteractionEnabled = true
                        cell?.textLabel?.enabled = true
                        cell?.detailTextLabel?.enabled = true
                        
                    }

                   
                }
                else if sectionType == 3{
                    quiz[indexPath.row].checked = 0;
                    nothingSelectedQuiz = true
                    var sectionID = quiz[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                        
                    }
                    for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        
                        cell?.userInteractionEnabled = true
                        cell?.textLabel?.enabled = true
                        cell?.detailTextLabel?.enabled = true
                        
                    }

                  
                }
                else{
                    other[indexPath.row].checked = 0;
                    nothingSelectedOther = true
                    var sectionID = other[indexPath.row].section
                    for var i = 0; i < selectedSections.count; i++ {
                        
                        if selectedSections[i].section == sectionID
                        {
                            selectedSections.removeAtIndex(i)
                        }
                        
                    }
                    for(var i=0; i < self.tableView.numberOfRowsInSection(sectionType); i++)
                    {
                        
                        var indexPathForDisablingInteraction = NSIndexPath(forRow: i, inSection: sectionType)
                        cell = tableView.cellForRowAtIndexPath(indexPathForDisablingInteraction)
                        
                        cell?.userInteractionEnabled = true
                        cell?.textLabel?.enabled = true
                        cell?.detailTextLabel?.enabled = true
                        
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
