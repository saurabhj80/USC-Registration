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
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
        
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var deptView = segue.destinationViewController as DeptTableViewController
        
        // Pass the selected object to the new view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let selectedSchool = schoolArray[indexPath.row].schoolDescription
            deptView.schoolname = selectedSchool
            deptView.schoolcode = schoolArray[indexPath.row].schoolCode
        }
    }

    
    

}
