//
//  SchoolTableViewController.swift
//  USC Reg
//
//  Created by Chaitu on 2/21/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

protocol SchoolTableViewControllerDelegate {
 
    func reloadTable(controller: SchoolTableViewController,  dataArray: [school])
    
}

class SchoolTableViewController: UITableViewController {
        
    var schoolArray : [school] = []
    var delegate:SchoolTableViewControllerDelegate?  = nil
    

    @IBAction func loadBtn(sender: AnyObject) {
        
        println(schoolArray.count)

    }
    //var testArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testArray.append("dafdsaf")
        //testArray.append("blah")
        //testArray.append("dadm")
        
        schoolArray = []
        self.delegate = localStorage()
        delegate?.reloadTable(self, dataArray: schoolArray)
        println(schoolArray.count)

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
        return schoolArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("schoolCell", forIndexPath: indexPath) as UITableViewCell
        println("fetching cells", indexPath.row)

        // Configure the cell...
        var schoolName = schoolArray[indexPath.row].schoolDescription
        cell.textLabel?.text = schoolName
        println("fetching cells", indexPath.row)
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
        
        var deptView = segue.destinationViewController as DeptTableViewController
        
        // Pass the selected object to the new view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let selectedSchool = schoolArray[indexPath.row].schoolDescription
            deptView.schoolname = selectedSchool
            deptView.schoolcode = schoolArray[indexPath.row].schoolCode
        }
    }

    
    

}
