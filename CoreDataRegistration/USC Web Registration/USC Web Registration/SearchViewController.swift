//
//  SearchViewController.swift
//  USC Web Registration
//
//  Created by Chaitu on 2/27/15.
//  Copyright (c) 2015 Darvish Kamalia. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var depName: UITextField!
    @IBOutlet weak var corName: UITextField!
    @IBOutlet weak var units: UITextField!
    @IBOutlet weak var keywords: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 120.0/256, green: 0.0/256, blue: 0.0/256, alpha: 1)
        
        depName.delegate = self;
        corName.delegate = self;
        units.delegate = self;
        keywords.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        depName.resignFirstResponder()
        corName.resignFirstResponder()
        units.resignFirstResponder()
        keywords.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func dismiss(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "searchSegue"
        {
            var vc = segue.destinationViewController as SearchResultsTableViewController
            vc.coursename = self.corName.text;
            vc.deptname = self.depName.text
            vc.keywords = self.keywords.text
            
            if self.units.text != ""
            {
                vc.units = Double(self.units.text.toInt()!)
                
            } else
            {
                vc.units = 1000.0;
            }
        }
        
    }

}
